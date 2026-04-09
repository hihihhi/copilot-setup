---
applyTo: "**/*.ts,**/*.tsx"
---

# TypeScript Rules

- Explicit return types on all exported functions.
- No `any` — use `unknown` and narrow, or define the type.
- Prefer `interface` for object shapes that may be extended; `type` for unions and computed types.
- Use `readonly` for properties that shouldn't be mutated after construction.
- Null checks: use optional chaining (`?.`) and nullish coalescing (`??`), not `|| ""`.
- Async functions must be `async` — don't return `Promise<T>` manually unless wrapping.
- Imports: named imports preferred. Avoid `import * as`.
- Enums: prefer `const` enums or union types — regular enums compile poorly.
- No `!` non-null assertions without a comment explaining why it's safe.
- `zod` or equivalent for runtime validation at API boundaries — TypeScript types are compile-time only.
