---
name: code-review
description: Comprehensive code review covering correctness, security, performance, and maintainability
---

Review the selected code. Structure your review as:

## Correctness
- Logic errors, edge cases not handled, off-by-one errors
- Incorrect assumptions about inputs or state
- Race conditions or concurrency issues

## Security
- Injection risks (SQL, command, XSS)
- Authentication/authorization gaps
- Secrets or sensitive data in code or logs
- Unsafe deserialization or data handling

## Performance
- N+1 queries or unnecessary iterations
- Missing indexes (flag for DB queries)
- Memory leaks or unbounded allocations
- Synchronous blocking in async contexts

## Maintainability
- Functions doing more than one thing
- Duplication that should be abstracted (only if used 3+ times)
- Names that don't reflect what the code actually does
- Missing error handling at system boundaries

## What's Good
- Note patterns done well — not just problems

Format each finding as:
`[SEVERITY: critical/high/medium/low] Line N: <finding> → <suggested fix>`

End with: **Overall assessment** in one sentence.
