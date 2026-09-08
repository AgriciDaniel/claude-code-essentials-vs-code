# Claude Code Essentials for VS Code

This repository provides opt-in Windows PowerShell and Bash setup entrypoints,
focused guides and optional project templates.

- scripts/setup.ps1 and scripts/setup.sh own behavior.
- install-extensions entrypoints delegate to setup with the same safety defaults.
- Preview is default; selected installs require Apply/--apply.
- Never add bulk OS upgrades, hidden installs, automatic authentication,
  permission bypass aliases or user-profile template writes.
- Preserve existing installations. Check exit codes and postconditions.
- Test with python tests/test_package.py; fake external processes and disposable
  storage only. Real installer tests require separately proven confinement.
- Keep docs/validation.md honest about which native OS and installer paths ran.
- Source provenance: baseline 8b5575bff5f6cd3f0f964df54010233d9b04c010.
