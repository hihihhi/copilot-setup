---
name: security-review
description: Security-focused audit against OWASP Top 10 and common vulnerability patterns
---

Perform a security audit of the selected code. Check for:

## OWASP Top 10
1. **Injection** — SQL, command, LDAP, XSS injection vectors
2. **Broken Auth** — weak session management, missing rate limiting, predictable tokens
3. **Sensitive Data** — unencrypted PII, secrets in code/logs, weak encryption
4. **XXE** — XML external entity processing
5. **Broken Access Control** — missing authorization checks, IDOR vulnerabilities
6. **Security Misconfiguration** — debug mode, default creds, verbose errors
7. **XSS** — reflected, stored, DOM-based
8. **Insecure Deserialization** — untrusted data deserialization
9. **Known Vulnerabilities** — outdated dependencies with CVEs
10. **Logging Failures** — missing audit logs, logging sensitive data

## Additional Checks
- Hardcoded secrets, API keys, or credentials
- Unsafe regex (ReDoS vulnerability)
- Path traversal vulnerabilities
- SSRF (Server-Side Request Forgery)
- Mass assignment / parameter pollution

## Output Format
For each finding:
```
[CVE/CWE if applicable]
Severity: Critical / High / Medium / Low
Location: file:line
Issue: <what's wrong>
Impact: <what an attacker can do>
Fix: <concrete remediation>
```

End with a risk summary: overall risk level and top 3 priority fixes.
