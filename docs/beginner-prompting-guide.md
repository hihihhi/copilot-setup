# Beginner Prompting Guide — GitHub Copilot

> **Goal:** With minimal effort, get Copilot to do exactly what you want. Most people get mediocre results because they write vague prompts. This guide fixes that in 10 minutes.

---

## The Core Rule: Context First, Request Second

Copilot's output quality depends almost entirely on **what it can see**, not how clever your prompt is.

Before writing anything in Copilot Chat:
1. **Open the relevant file** — Copilot reads open files automatically
2. **Select the specific code** you want to talk about — highlighted code is highest priority
3. **Close irrelevant tabs** — 20 open files dilute attention

---

## The 4-Part Prompt Formula

```
[Role] + [Context] + [Request] + [Constraint]
```

| Part | Bad example | Good example |
|---|---|---|
| Role | *(nothing)* | "As a security reviewer…" |
| Context | "this function" | "the `createUser` function in `routes/users.ts`" |
| Request | "fix it" | "add input validation for the email field" |
| Constraint | *(nothing)* | "without changing the function signature" |

**Full example:**
```
As a backend developer, looking at the createUser function in routes/users.ts,
add input validation for the email and password fields.
Reject empty strings and email addresses without an @ symbol.
Do not change the function signature or add new dependencies.
```

---

## Quick Reference: Prompt Templates

Copy-paste these and fill in the blanks:

### Add a feature
```
Add [feature] to [file/function].
It should [behavior description].
Do not [constraint — what NOT to change].
```

### Fix a bug
```
In [file], the [function/component] [describes the wrong behavior].
It should instead [correct behavior].
Here is the error: [paste error message]
```

### Code review
```
/code-review
```
*(Just type this. The installed configuration does the rest.)*

### Security audit
```
/security-review
```

### Write tests
```
/tdd
Write tests for [function name] in [file].
Cover: happy path, empty input, [specific edge case].
```

### Refactor
```
/refactor
Improve the readability of [function/file] without changing its behavior.
```

### Debug
```
/debug
[paste the error or describe the symptom]
```

---

## Context Clarification — The Fastest Way to Improve Results

If Copilot gives a wrong answer, don't start over. **Clarify:**

| Problem | What to add |
|---|---|
| Wrong tech stack | "We use Express, not Fastify" |
| Wrong test style | "Use Jest with Arrange-Act-Assert, not describe/it" |
| Too much added | "Only change what was asked — no extra features" |
| Wrong level of abstraction | "This is production code, not a tutorial — no comments" |
| Missing type info | "All functions must have explicit TypeScript return types" |

**Example clarification chain:**
```
You:      Add pagination to the GET /tasks endpoint
Copilot:  [returns cursor-based pagination]
You:      We use page/limit pagination (page=1&limit=20), not cursors. Redo.
Copilot:  [returns correct page/limit version]
```

---

## File-Specific Rules — They Activate Automatically

This installation includes path-scoped rules. You don't need to say anything — they apply when you open the right file:

| File type | What Copilot automatically applies |
|---|---|
| `.ts`, `.tsx` | Strict TypeScript, no `any`, explicit return types |
| `routes/**`, `api/**` | RESTful naming, proper status codes, parameterized queries |
| `**/*.test.ts` | AAA structure, one assertion per test, mock only boundaries |
| `*.sql`, `migrations/**` | Parameterized queries, `IF NOT EXISTS` migrations |
| `Dockerfile`, `docker-compose.yml` | Multi-stage builds, pinned versions, non-root user |
| `components/**/*.tsx` | Functional components, stable keys, no inline styles |

---

## Common Mistakes (and Fixes)

| Mistake | Fix |
|---|---|
| "Improve this code" | "Reduce nesting in the `updateTask` function using early returns" |
| "Make it better" | "The `formatDate` function is called 3x with the same args — memoize it" |
| "Write tests" | "Write Jest tests for the `createTask` function. Cover: missing title (400), valid input (201), duplicate title (409)" |
| "Fix the bug" | Paste the full stack trace + "This happens when the user submits an empty form" |
| Asking about code that isn't open | Open the file first, then ask |

---

## One-Line Prompts That Work Well

```
/code-review                          # full review on selected code
/security-review                      # OWASP audit on selected code
/tdd                                  # start test-first development
/refactor                             # improve structure, keep behavior
/debug [paste error]                  # systematic debugging
/prd-to-plan [paste requirements]    # requirements → implementation plan
```

---

## When Copilot Gets Confused

1. **Close unrelated tabs** — open only what's relevant
2. **Start a new chat** — long sessions accumulate wrong context
3. **Be more specific** — add the file name, line number, or function name
4. **Restate constraints** — "only modify the `validate()` function, nothing else"
5. **Give an example** — "the output should look like: `{ error: 'title is required' }`"
