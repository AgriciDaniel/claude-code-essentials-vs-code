---
description: Create migration plan for upgrade
---
Create migration plan for: $ARGUMENTS

Steps:
1. Document current state and versions
2. Identify breaking changes in target version
3. Create step-by-step migration checklist
4. Propose codemods if applicable; do not write or execute them
5. Plan incremental dependency updates
6. Identify tests that would need updates for new APIs
7. Create rollback plan
8. Document post-migration verification steps

Output as checklist with estimated effort per step.
Flag any high-risk changes that need careful review.
This command is planning only. Do not edit files, run migrations, or change dependencies.
