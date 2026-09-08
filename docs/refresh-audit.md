# Setup refresh audit

Reviewed 2026-09-08 against upstream baseline
`8b5575bff5f6cd3f0f964df54010233d9b04c010`.
This is a local review candidate; publication of the original video is unrelated.

| Confirmed original issue | Resolution |
|---|---|
| All four entrypoints hide stderr; extension totals count attempts, not success | Checked exit codes, visible errors and inventory postconditions; no success on partial failure |
| Unconditional 26 extensions and force reinstalls | Explicit per-ID selection, preview default, skip existing, no force |
| Node 18 requirement and npm-only default | Native route; document current optional npm Node 22+ requirement |
| Nonexistent setup-claude-code entrypoints advertised | Remove nonexistent names; CLI-only flag on actual setup entrypoints |
| Global OS/package upgrades presented as routine upkeep | Product-specific update instructions only |
| Permanent skip-permissions profile alias, broad npm/npx/git/Python allow rules | Remove bypass advice and default preapprovals; empty settings object |
| Hook matcher objects, flattened command field, assumed TOOL_INPUT_PATH | Remove executable defaults and document current string matcher/nested hooks/stdin JSON |
| Skill-only fields in custom subagents | Correct agent templates |
| Unselected user-wide command/skill scaffolding | Templates now manual project-scoped choices, no profile writes |
| MCP registration treated as installed/ready, floating npm execution | No automatic MCP; explain scope, version review, runtime/auth verification |
| Stale model/feature roster, false version-as-login check | Current help/model/account workflow and precise executable-only checks |
| AI assistants/nightly/remote/extensions all “essential” | Full 26-ID primary-source audit and conditional selection guide |
| Missing prerequisite, unsupported OS, spaces, repeat/partial failure | Explicit validation and regression coverage; native matrix recorded separately |

Sources are linked near claims in the README and guides. The extension audit
records primary Marketplace observations, not binary security certification.
[Installation](https://code.claude.com/docs/en/setup),
[hooks](https://code.claude.com/docs/en/hooks),
[skills](https://code.claude.com/docs/en/skills),
[subagents](https://code.claude.com/docs/en/sub-agents),
[VS Code security](https://code.visualstudio.com/docs/configure/extensions/extension-runtime-security).

## Deliberate limits

This remains a small setup helper, not a package manager or sandbox. Applying
an installation delegates to vendor code. No frozen dependency lock is claimed:
native channels auto-update and VS Code resolves compatible extension releases.
Existing components are not migrated or upgraded. No account/service changes,
automatic template merge, binary extension audit, or whole-machine setup.

Vendor install success is verified with executable discovery/version output;
it does not prove every runtime feature. An existing broken executable fails
the check rather than triggering a blind reinstall. Exact version selection
applies only when absent and does not pin later updates.
