---
name: security
description: Security best practices
---
Always check for and prevent:

1. SQL injection - use parameterized queries only
2. XSS - escape all user input in HTML output
3. CSRF - use tokens for state-changing requests
4. Hardcoded secrets - use environment variables
5. Insecure dependencies - check npm audit / pip audit
6. Missing input validation - validate all user inputs
7. Improper error exposure - don't leak stack traces
8. Missing authentication - verify auth on all protected routes
9. Broken access control - check authorization for every action
10. Sensitive data exposure - encrypt at rest and in transit
