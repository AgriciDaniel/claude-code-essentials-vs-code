# Contributing

Report ordinary bugs with native OS/shell versions, candidate revision, exact
sanitized command, exit code and relevant output through
[GitHub issues](https://github.com/AgriciDaniel/claude-code-essentials-vs-code/issues).
Remove credentials and personal paths. Follow [SECURITY.md](SECURITY.md) for
vulnerabilities.

For changes, use a branch and inspect the existing script conventions. Keep
Windows PowerShell 5.1 and macOS Bash 3.2 compatibility explicit. Run
`python tests/test_package.py` (or python3) without installing real products.
Use `SETUP_TEST_SHELL` to select a shell. Keep docs/validation.md and the
candidate receipt honest about actual native platforms and mocked substeps.

Test error propagation, preview/consent, repeated execution, paths with spaces,
unsupported conditions and partial success. Avoid dependencies that require
a global install merely to run the test suite. Confirm source ZIP extraction
is self-contained and excludes caches, secrets and local paths.

A local patch/test result is not upstream publication. Submit a reviewed PR
only with the repository owner's authorization and include tests and residuals.
