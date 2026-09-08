# Claude Code: first use and optional customization

Start with the [README](../README.md) and [platform guide](dev-setup-guide.md).
The official extension and standalone CLI are separate choices. Use current
`/help` and `/model` output rather than a hardcoded model/version roster.

## Sign-in and verification

Run `claude` in your project and follow sign-in. The official extension also
offers sign-in. Choose your intended subscription, Console or provider route;
Console/API usage is billed separately from subscription access.
`claude --version` checks the executable; it does not verify sign-in.
Use the session's `/status` and account UI to inspect your active account.
[Authentication](https://code.claude.com/docs/en/authentication).

For installation/configuration diagnostics, run `claude doctor`. Review its
findings before changing anything. Don't delete caches/configuration or disable
permissions as a generic repair. Keep the normal permission flow; review
`/permissions` for narrowly scoped changes. This package does not recommend
a persistent shell alias that bypasses permissions.

## Settings and templates

Claude settings and VS Code settings are different formats. Project Claude
settings go in `.claude/settings.json`, private local settings in
`.claude/settings.local.json`, user settings in `~/.claude/settings.json`.
Managed settings may override these. [Settings](https://code.claude.com/docs/en/settings).

`templates/settings.json` is intentionally an empty valid object. It is a
Claude template, **not** VS Code settings. It grants no extra permissions and
runs no hooks. Inspect existing files and merge only chosen keys; never
overwrite a user's settings with this template.

Copy only selected template files into a project you control after reading
them. The installer copies none. Use `templates/CLAUDE.md` as editable project
instructions, `templates/skills/<name>/SKILL.md` under
`.claude/skills/<name>/SKILL.md`, and `templates/agents/<name>.md` under
`.claude/agents/<name>.md`. These are examples, not a validated policy engine.

Custom commands in `.claude/commands/*.md` remain supported, but skills are
the current unified extension format. Skills may be selected by description
or invoked explicitly; `disable-model-invocation: true` restricts a skill to
explicit invocation. Do not confuse skill `context: fork` / `agent` fields
with a custom subagent's frontmatter.
[Skills](https://code.claude.com/docs/en/skills) ·
[Subagents](https://code.claude.com/docs/en/sub-agents).

## Hooks

There are no executable hooks in the default settings. Current hook
configuration uses a **string** matcher and a nested `hooks` list, e.g.
`{"matcher":"Write|Edit","hooks":[{"type":"command","command":"..."}]}`
inside an event list. Command hooks receive JSON on stdin; select
`tool_input.file_path` in your handler and pass it as an argument, not an
unquoted shell string. The former `$TOOL_INPUT_PATH` assumption is removed.
Test hooks against your shell and tools before enabling them.
[Hooks reference](https://code.claude.com/docs/en/hooks).

## MCP and plugins: optional, per integration

MCP servers execute code or send data to another service. Pick one because the
project needs it; inspect provider ownership, access, dependencies and data scope
first. Registration is not proof the server starts or is authenticated.
No MCP server is registered by this setup.

Use `claude mcp add --help` from your installed CLI and explicitly choose
`--scope local` (private to the current project), `project` (shared
`.mcp.json`) or `user` (all projects). Inspect existing configuration before
adding a name. Keep secrets out of command history and committed JSON.
Windows stdio commands using npm launchers have different quoting/launcher
requirements from Unix; use the current vendor recipe, not an untested copied
Unix command. For npm-based servers select and review an exact package version;
a floating `latest` or `npx -y` executes code without a package-install prompt.
[MCP documentation](https://code.claude.com/docs/en/mcp).

For plugins, review the marketplace and plugin source before installing; a
plugin may include hooks, MCP, agents and skills. Use the current vendor
marketplace workflow rather than treating an arbitrary repository URL as a
universal install command. [Plugins](https://code.claude.com/docs/en/plugins).
