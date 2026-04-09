---
applyTo: "**/*.tsx,**/components/**/*.ts"
---

# React Rules

- Functional components only — no class components.
- Props interface defined above the component, named `<ComponentName>Props`.
- Custom hooks in `hooks/` directory, named `use<Name>`.
- `useEffect` dependencies must be complete and correct — no suppression comments without explanation.
- No direct DOM manipulation — use refs when unavoidable.
- State that belongs together stays together (`useReducer` over multiple `useState`).
- Keys in lists: stable unique IDs — never array index unless list is static.
- Memoization (`useMemo`, `useCallback`, `React.memo`) only when profiling shows a problem.
- Event handlers: named `handle<Event>` (e.g. `handleSubmit`, `handleClick`).
- Avoid prop drilling beyond 2 levels — use context or state management.
