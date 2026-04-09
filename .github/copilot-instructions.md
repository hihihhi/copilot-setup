---
# Copilot Behavioral Contract
# Always applied to every Copilot request.
# Air-gapped safe: no external links, all knowledge is embedded here.
---

## Think Before Coding
- State assumptions explicitly before implementing. Multiple interpretations → list them.
- Unclear requirement → stop and ask. Never guess and implement.
- Simpler approach exists → say so before building the complex one.

## Simplicity First
- No features beyond what was asked. No speculative abstractions.
- No flexibility or configurability that wasn't requested.
- No error handling for impossible scenarios.
- Self-test: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## Surgical Changes
- Every changed line must trace directly to the request.
- Match existing code style, naming, and patterns — even if you'd do it differently.
- Don't fix adjacent unrelated issues. Mention them, don't fix them.
- Don't add comments, docstrings, or type hints to code you didn't change.

## Goal-Driven Execution
Transform tasks into verifiable goals first:
- "Add validation" → write tests for invalid inputs, then make them pass
- "Fix the bug" → write a test that reproduces it, then fix it
- "Refactor X" → ensure tests pass before and after

Multi-step plan format (always state this before starting):
```
1. [action] → verify: [check]
2. [action] → verify: [check]
```

## Offline-First Rules
This environment may not have internet access. Apply these rules always:
- **Never suggest installing a new package** unless it is already in `package.json`
  or `requirements.txt`. If something is missing, say: "This requires `X` — add it
  to package.json before proceeding."
- **Check existing usage first.** Before writing code using a library, look for
  existing usage in the codebase — that is the source of truth for the actual API,
  not documentation.
- **No external links.** Do not reference URLs to docs. Embed the knowledge here.
- **Conservative syntax.** Match the language/framework version used in the project
  (check package.json `engines` field or existing code patterns).
- **No version assumptions.** If a newer API might not be available, use the pattern
  already established in the codebase.

## Security (non-negotiable)
- Never hardcode API keys, tokens, passwords, or secrets — use environment variables.
- Never log sensitive data (passwords, tokens, PII, session IDs).
- Sanitize all user input before use in SQL, shell commands, or HTML output.
- Validate at system boundaries only. Trust internal code.
- Parameterized queries always — never string-interpolate into SQL.

## Code Quality
- Max 100 characters per line. Functions do one thing.
- No dead code, no commented-out code.
- No backwards-compatibility shims for things that no longer exist.
- Conventional commits: `feat:` `fix:` `chore:` `docs:` `refactor:` `test:` `perf:`

## Language Defaults
- TypeScript over JavaScript when a choice exists.
- Explicit types — avoid `any`. Use `unknown` and narrow instead.
- Prefer composition over inheritance.
- Errors are values — handle them explicitly, don't swallow them.

## Error Handling Patterns

Prefer explicit Result types over thrown exceptions for expected failures:
```ts
type Result<T, E = string> = { ok: true; value: T } | { ok: false; error: E }

async function getUser(id: string): Promise<Result<User>> {
  const user = await db.findById(id)
  if (!user) return { ok: false, error: 'user_not_found' }
  return { ok: true, value: user }
}
```
Reserve `throw` for programmer errors (wrong config at startup, impossible invariants).
At async boundaries: always `try/catch`, log with context, return a typed error.

## Naming Conventions
- Variables/functions: `camelCase`. Types/interfaces/classes: `PascalCase`.
- Constants: `SCREAMING_SNAKE_CASE` for true module-level constants.
- Booleans: `is`, `has`, `can`, `should` prefix (`isLoading`, `hasPermission`).
- Functions: verb-first (`getUserById`, `validateEmail`, `formatCurrency`).
- Files: `kebab-case.ts` for modules, `PascalCase.tsx` for React components.
- DB columns: `snake_case`. JSON API fields: `camelCase`.
- Test files: `<subject>.test.ts` co-located with the module under test.

## Architecture Defaults
When the project doesn't specify otherwise:
- **HTTP API shape**: `{ data?: T, error?: { code, message }, meta?: { page, total } }`
- **Validation**: zod (TypeScript) or pydantic (Python) — at API boundary only
- **Auth**: JWT in `Authorization: Bearer <token>` — checked before business logic
- **Pagination**: cursor-based over offset (consistent under concurrent writes)
- **IDs**: UUID v4 for public-facing IDs, auto-increment for internal DB PKs
- **Dates**: ISO 8601 strings over the wire (`2024-01-15T10:30:00Z`), Date internally
- **Config**: env vars validated at startup in a single typed config module

## Key Patterns

### Environment config (validated at startup)
```ts
// config.ts — fail fast on missing required config
function required(key: string): string {
  const v = process.env[key]
  if (!v) throw new Error(`Missing required env var: ${key}`)
  return v
}
export const config = {
  port: Number(process.env.PORT ?? 3000),
  dbUrl: required('DATABASE_URL'),
  jwtSecret: required('JWT_SECRET'),
}
```

### Standard API handler
```ts
// validate → authenticate → authorize → execute
async function handler(req, res) {
  const parsed = RequestSchema.safeParse(req.body)
  if (!parsed.success) return res.status(400).json({ error: parsed.error.flatten() })
  const user = await requireAuth(req)              // throws 401 if invalid
  await requirePermission(user, 'resource:action') // throws 403 if unauthorized
  const result = await executeBusinessLogic(parsed.data)
  return res.status(200).json({ data: result })
}
```

### Database queries — always parameterized
```ts
// WRONG — SQL injection: `SELECT * FROM users WHERE id = ${id}`
// RIGHT — parameterized:
const user = await db.query('SELECT * FROM users WHERE id = $1', [id])
```

## Testing Philosophy
- **Unit**: pure functions, business logic — no I/O, runs in milliseconds
- **Integration**: hit real DB/filesystem — test the actual system, not mocks of it
- **Mock only**: external services (email, payments, 3rd-party APIs)
- Every bug fix gets a regression test that reproduces the bug before the fix
- Test the public API / observable behavior — not internal implementation details
