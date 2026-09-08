#!/usr/bin/env bash
# Bash 3.2+. Run from a reviewed local checkout.
set -euo pipefail
trap 'printf "ERROR: setup failed; earlier steps remain installed. Review output before retrying.\n" >&2' ERR
apply=false
install_claude=false
version=stable
code_command=code
code_data=''
code_extensions=''
code_args=()
code_target='the default profile'
extensions=()
die() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }
while [[ $# -gt 0 ]]; do
    case "$1" in
        --apply) apply=true; shift ;;
        --install-claude) install_claude=true; shift ;;
        --claude-version|--extension|--code-command|--code-user-data-dir|--code-extensions-dir)
            [[ $# -ge 2 && -n "$2" ]] || die "Missing value for $1"
            case "$1" in
                --claude-version) version=$2 ;;
                --code-command) code_command=$2 ;;
                --code-user-data-dir) code_data=$2 ;;
                --code-extensions-dir) code_extensions=$2 ;;
                --extension)
                    [[ "$2" =~ ^[a-zA-Z0-9][a-zA-Z0-9-]*\.[a-zA-Z0-9][a-zA-Z0-9-]*$ ]] || die "Invalid extension ID: $2"
                    id=$(printf '%s' "$2" | tr '[:upper:]' '[:lower:]')
                    duplicate=false
                    for existing in "${extensions[@]+"${extensions[@]}"}"; do [[ "$existing" != "$id" ]] || duplicate=true; done
                    $duplicate || extensions+=("$id") ;;
            esac
            shift 2 ;;
        --help|-h)
            printf '%s\n' 'Preview: bash scripts/setup.sh [--install-claude] [--claude-version stable|latest|X.Y.Z] [--extension publisher.extension ...]' 'Execute choices: add --apply. Optional --code-command /path/to/code.'
            exit 0 ;;
        *) die "Unknown option: $1" ;;
    esac
done
[[ "$version" =~ ^(stable|latest|[0-9]+\.[0-9]+\.[0-9]+)$ ]] || die 'Invalid Claude version'
if [[ -n "$code_data" || -n "$code_extensions" ]]; then
    [[ -n "$code_data" && -n "$code_extensions" ]] || die 'Specify both VS Code directories for an isolated target.'
    code_args=(--user-data-dir "$code_data" --extensions-dir "$code_extensions")
    code_target='the explicit storage directories shown below'
fi
case "$(uname -s)" in Darwin|Linux) ;; *) die 'Use setup.ps1 for native Windows; use this script inside WSL, Linux or macOS.' ;; esac
$install_claude && printf 'PLAN: native Claude (%s) if absent; execute https://claude.ai/install.sh as this user. Vendor auto-updates apply.\n' "$version"
for id in "${extensions[@]+"${extensions[@]}"}"; do
    printf 'PLAN: missing VS Code extension %s in %s. Dependencies may also install; review publisher and permissions.\n' "$id" "$code_target"
done
if [[ -n "$code_data" ]]; then printf 'VS Code override: user data=%s; extensions=%s\n' "$code_data" "$code_extensions"; fi
if ! $install_claude && [[ ${#extensions[@]} -eq 0 ]]; then printf 'No components selected. Use --install-claude and/or --extension publisher.extension.\n'; fi
if ! $apply; then printf 'Preview only. No downloads or profile writes. Add --apply to execute choices.\n'; exit 0; fi
installed=''
if [[ ${#extensions[@]} -gt 0 ]]; then
    command -v "$code_command" >/dev/null || die 'VS Code CLI missing. See docs/dev-setup-guide.md; reopen terminal after fixing PATH.'
    installed=$("$code_command" "${code_args[@]+"${code_args[@]}"}" --list-extensions)
fi
find_claude() {
    if command -v claude >/dev/null; then command -v claude
    elif [[ -x "$HOME/.local/bin/claude" ]]; then printf '%s\n' "$HOME/.local/bin/claude"
    fi
}
if $install_claude; then
    claude_command=$(find_claude)
    already_present=false
    if [[ -n "$claude_command" ]]; then
        already_present=true
        printf 'SKIP: existing Claude at %s; version/channel unchanged.\n' "$claude_command"
    else
        command -v curl >/dev/null || die 'curl required for native installation; install separately for your OS.'
        installer_dir=$(mktemp -d)
        trap 'rm -f "$installer_dir/install.sh"; rmdir "$installer_dir"' EXIT
        curl --fail --show-error --silent --location --proto '=https' --proto-redir '=https' https://claude.ai/install.sh -o "$installer_dir/install.sh"
        [[ -s "$installer_dir/install.sh" ]] || die 'Installer download is empty'
        bash "$installer_dir/install.sh" "$version"
        claude_command=$(find_claude)
        [[ -n "$claude_command" ]] || die 'Installer returned success but Claude not found on PATH or in ~/.local/bin; unverified.'
    fi
    actual_version=$("$claude_command" --version)
    [[ "$actual_version" =~ [0-9]+\.[0-9]+\.[0-9]+ ]] || die 'Claude returned no recognizable version; unverified.'
    reported_version=${BASH_REMATCH[0]}
    if ! $already_present && [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ && "$reported_version" != "$version" ]]; then
        die "Requested Claude $version but found $reported_version; verification failed."
    fi
    printf 'VERIFIED executable: %s (authentication not checked).\n' "$actual_version"
fi
for id in "${extensions[@]+"${extensions[@]}"}"; do
    if printf '%s\n' "$installed" | tr -d '\r' | grep -Fxi -- "$id" >/dev/null; then
        printf 'SKIP: %s already installed; no force/update.\n' "$id"
        continue
    fi
    "$code_command" "${code_args[@]+"${code_args[@]}"}" --install-extension "$id"
    after=$("$code_command" "${code_args[@]+"${code_args[@]}"}" --list-extensions)
    printf '%s\n' "$after" | tr -d '\r' | grep -Fxi -- "$id" >/dev/null || die "$id absent after installation; verification failed."
    printf 'VERIFIED extension: %s\n' "$id"
done
printf 'Selected steps finished. Authentication, MCP, templates, permissions and editor settings were not configured.\n'
