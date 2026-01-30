---
description: Generate comprehensive tests for a file or function
---
Generate comprehensive tests for: $ARGUMENTS

Requirements:
1. **Unit Tests**: Test each function in isolation
2. **Edge Cases**: Empty inputs, null values, boundary conditions
3. **Error Scenarios**: Invalid inputs, network failures, timeouts
4. **Integration Tests**: If the code interacts with other modules

Follow these patterns:
- Use the existing test framework in the project
- Match the project's test file naming convention
- Use descriptive test names: "should [expected behavior] when [condition]"
- Group related tests with describe blocks
- Use proper mocking for external dependencies
- Aim for high coverage but prioritize meaningful tests

After generating:
1. Run the tests to verify they pass
2. Check coverage if available
3. Suggest any additional test cases
