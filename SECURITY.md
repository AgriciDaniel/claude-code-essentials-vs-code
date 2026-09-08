# Security policy

Report a suspected vulnerability privately to the maintainer. Use the
repository's GitHub security reporting flow if enabled; do not disclose secrets
or exploit details in a public issue.

## Scope of this helper

Preview performs no installation. Apply executes the selected vendor installer
and/or VS Code CLI with the current user's authority. It is not a sandbox.
Vendor code, extension dependencies and package-manager behavior may change;
review those sources before installing.

The wrapper does not store credentials, change permission policy, configure
authentication, install Python dependencies or copy templates to a user profile.
Do not infer that an extension listing or this source review proves a downloaded
binary safe. Use [vendor integrity guidance](https://code.claude.com/docs/en/setup)
and [VS Code security guidance](https://code.visualstudio.com/docs/configure/extensions/extension-runtime-security).

Use disposable environments for integration tests, with paired Code storage
directories and an independently proven boundary for native installers.
See [validation](docs/validation.md). Keep credentials and machine-specific
logs out of source packages and issue attachments.
