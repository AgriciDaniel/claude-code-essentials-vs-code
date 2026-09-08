# Changelog

## Local refresh candidate: 2026-09-08

Based on AgriciDaniel/claude-code-essentials-vs-code commit
`8b5575bff5f6cd3f0f964df54010233d9b04c010` (short `8b5575b`).
This is an unpublished source candidate, not an upstream release.

- Replace unconditional 26-extension force installs with explicit selections and
  preview by default. Keep both original setup and extension-only entrypoints.
- Use native Claude installation for missing CLI; preserve existing versions.
- Check process failures and installation postconditions; stop partial failures.
- Add paired VS Code storage overrides and path-safe argument arrays.
- Remove invalid hooks, broad preapprovals, permanent permission-bypass advice,
  bulk OS upgrades, nonexistent script references and obsolete Node 18 guidance.
- Refresh all guides, template frontmatter and extension relevance audit.
- Add isolated tests, provenance and an explicit actual-platform validation record.
- Resolve native fleet fixture gaps and review findings: Bash large-inventory
  pipe failures, exact fresh-version checking, stale PowerShell wrapper exit
  status, partial-failure retry, unknown/missing options and source manifests.

Breaking behavior: the historical piped one-liner no longer installs everything.
Use an extracted/reviewed checkout and explicit component flags plus apply.
