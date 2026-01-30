---
description: Generate documentation for code
---
Generate documentation for: $ARGUMENTS

Include:
1. **Function/Class Docstrings**
   - Description of purpose
   - @param for each parameter with type and description
   - @returns with type and description
   - @throws for possible errors
   - @example with usage example

2. **Inline Comments**
   - Explain complex logic
   - Note any non-obvious decisions
   - Mark TODOs or FIXMEs

3. **README Sections** (if applicable)
   - Installation instructions
   - Usage examples
   - API reference
   - Configuration options

4. **Type Annotations**
   - Add or improve TypeScript types
   - Document complex types with JSDoc

Format according to the project's existing documentation style.
If no style exists, use JSDoc for JavaScript/TypeScript.
