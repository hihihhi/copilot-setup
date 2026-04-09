---
name: commit
description: Generate a conventional commit message from the current diff or staged changes
---

Generate a conventional commit message for the changes described or shown.

## Commit Message Format
```
<type>(<scope>): <subject>

<body — optional, only if WHY isn't obvious from the subject>

<footer — optional: BREAKING CHANGE, closes #issue>
```

## Types
| Type | When to use |
|------|-------------|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `refactor` | Code change that is neither a fix nor a feature |
| `perf` | Performance improvement |
| `test` | Adding or updating tests |
| `docs` | Documentation only |
| `chore` | Build, tooling, dependencies, CI changes |
| `style` | Formatting, whitespace — no logic change |

## Rules for the Subject Line
- Imperative mood: "add user validation" not "added" or "adds"
- Lowercase — no capital first letter, no period at end
- Max 72 characters
- Scope is optional but useful for large codebases: `feat(auth):`, `fix(api):`
- Describe WHAT changed, not HOW: "add rate limiting to /login" not "add counter variable"

## When to Include a Body
Include a body only when the subject can't capture:
- WHY this change was made (motivation, context)
- What the alternative was and why it was rejected
- Non-obvious side effects

## Breaking Changes
If the change breaks the existing API:
```
feat(api)!: change user endpoint to return paginated response

BREAKING CHANGE: /users now returns { data: User[], meta: { cursor } }
instead of User[]. Update all clients.
```

## Output
Provide:
1. The commit message (ready to copy-paste)
2. One-line rationale for the type chosen (if non-obvious)
