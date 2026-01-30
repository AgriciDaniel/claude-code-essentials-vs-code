---
description: Perform security audit on codebase
---
Audit security for: $ARGUMENTS

Check for:
1. SQL injection vulnerabilities
2. XSS in templates/outputs
3. CSRF protection gaps
4. Authentication/authorization flaws
5. Hardcoded secrets or credentials
6. Insecure dependencies (run npm audit / pip audit)
7. Input validation gaps
8. Error information exposure
9. Insecure file operations
10. Missing rate limiting

Rate each finding: Critical > High > Medium > Low
Provide specific fixes for each vulnerability found.
