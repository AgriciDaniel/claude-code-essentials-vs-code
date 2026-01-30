---
description: Analyze and fix a GitHub issue
---
Please analyze and fix GitHub issue: $ARGUMENTS

Follow these steps:
1. Use `gh issue view $ARGUMENTS` to get issue details
2. Understand the problem described
3. Search the codebase for relevant files
4. Implement the necessary fix
5. Write tests to verify the fix
6. Run linter and fix any issues
7. Commit with message: "fix: resolve #$ARGUMENTS - [brief description]"

Be thorough and ensure the fix doesn't break existing functionality.
