---
applyTo: "**/*.ts,**/*.tsx"
---

# TypeScript Rules

## Types
- Explicit return types on all exported functions — no inference for public API.
- No `any` — use `unknown` and narrow with type guards, or define the shape.
- Prefer `interface` for extendable object shapes; `type` for unions, intersections, computed types.
- Use `readonly` for properties that shouldn't mutate after construction.
- No `!` non-null assertions without a comment explaining why it's safe.
- `const` enums or union string literals over `enum` — enums have poor tree-shaking.

## Null Safety
```ts
// Prefer: optional chaining + nullish coalescing
const name = user?.profile?.name ?? 'Anonymous'

// Avoid: truthy coercion (breaks for empty string, 0)
const name = user && user.profile && user.profile.name || 'Anonymous'
```

## Async
- Functions that do async work must be declared `async` — don't return `Promise<T>` manually.
- Always `await` promises before the function returns — don't fire and forget unless intentional.
- Handle rejection: either `try/catch` in the caller or chain `.catch()` on fire-and-forget.

## Imports
- Named imports preferred over default imports for better refactor safety.
- Avoid `import * as X` — import only what's used.
- Group: third-party first, then internal, blank line between groups.

## Validation (at API/input boundaries only)
Use zod if it's in the project. Pattern:
```ts
import { z } from 'zod'

const UserSchema = z.object({
  email: z.string().email(),
  age: z.number().int().min(0).max(120),
})

// At the boundary:
const parsed = UserSchema.safeParse(req.body)
if (!parsed.success) {
  return res.status(400).json({ error: parsed.error.flatten() })
}
// parsed.data is now fully typed
```

## Error Handling
```ts
// For expected failures — use Result type (errors visible in signature)
type Result<T, E = string> = { ok: true; value: T } | { ok: false; error: E }

// For boundary errors — catch and re-throw with context
try {
  return await externalCall()
} catch (err) {
  throw new Error(`Failed to call X: ${err instanceof Error ? err.message : String(err)}`)
}
```

## Common Anti-Patterns to Avoid
```ts
// 1. Untyped catch binding
} catch (e) { console.log(e.message) }  // 'e' is unknown
// Fix: if (e instanceof Error) { console.log(e.message) }

// 2. Index access without check
const first = items[0].name  // crashes on empty array
// Fix: const first = items[0]?.name ?? ''

// 3. Floating promise
doSomethingAsync()  // unhandled rejection
// Fix: await doSomethingAsync() or void doSomethingAsync().catch(handleErr)

// 4. Type assertion over narrowing
const x = value as User  // bypasses type safety
// Fix: use a type guard or parse with zod
```

## File Organization
- One module = one responsibility. If a file needs more than 3 imports from the same place, extract a layer.
- Co-locate tests: `user-service.ts` + `user-service.test.ts` in same directory.
- Barrel files (`index.ts`) for public API of a directory — keep them thin.
