#!/usr/bin/env bash
set -euo pipefail
for argument in "$@"; do
    case "$argument" in --install-claude|--claude-version) printf 'Use setup.sh for Claude installation.\n' >&2; exit 1 ;; esac
done
exec bash "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/setup.sh" "$@"
