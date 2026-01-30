---
description: Review code for best practices and issues
---
Perform a thorough code review on: $ARGUMENTS

Check for:
1. **Security**: SQL injection, XSS, hardcoded secrets, input validation
2. **Performance**: N+1 queries, unnecessary re-renders, memory leaks
3. **Error Handling**: Try-catch blocks, error boundaries, user feedback
4. **Code Quality**: DRY violations, complexity, naming conventions
5. **Type Safety**: Proper TypeScript usage, any types, null checks
6. **Testing**: Test coverage, edge cases, mocking

For each issue found:
- Explain the problem
- Show the problematic code
- Provide a fixed version
- Explain why it's better

End with a summary of critical vs minor issues.
