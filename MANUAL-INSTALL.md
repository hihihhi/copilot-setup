# Manual Installation (Air-Gapped / No Script)

No internet, no git, no shell scripts required. Just copy files.

---

## What to Copy

Copy these 3 items into the root of your project:

```
your-project/
├── .github/
│   ├── copilot-instructions.md       ← always applied to every request
│   ├── instructions/                 ← path-scoped rules (auto-applied by file type)
│   │   ├── typescript.instructions.md
│   │   ├── python.instructions.md
│   │   ├── react.instructions.md
│   │   ├── api.instructions.md
│   │   ├── tests.instructions.md
│   │   ├── sql.instructions.md
│   │   ├── docker.instructions.md
│   │   └── frontend-aesthetics.instructions.md
│   └── prompts/                      ← slash commands in Copilot Chat
│       ├── code-review.prompt.md
│       ├── security-review.prompt.md
│       ├── tdd.prompt.md
│       ├── debug.prompt.md
│       ├── plan.prompt.md
│       ├── explain.prompt.md
│       ├── commit.prompt.md
│       ├── scaffold.prompt.md
│       ├── refactor.prompt.md
│       ├── prd-to-plan.prompt.md
│       └── deep-research.prompt.md
└── .vscode/
    └── settings.json                 ← instruction injection per task type
```

That's it. Commit these files. Every developer on the team gets the same Copilot behavior automatically.

---

## Minimum Install (if you only want the essentials)

If you can't copy everything, this is the priority order:

| Priority | File | Why |
|----------|------|-----|
| 1 (must) | `.github/copilot-instructions.md` | Core behavioral contract — always applied |
| 2 (must) | `.vscode/settings.json` | Enables instruction injection per task type |
| 3 (high) | `.github/instructions/typescript.instructions.md` | Most common file type |
| 3 (high) | `.github/instructions/python.instructions.md` | |
| 4 (recommended) | `.github/prompts/code-review.prompt.md` | Most-used prompt |
| 4 (recommended) | `.github/prompts/plan.prompt.md` | Plan before implementing |
| 5 (optional) | All other instruction files | Add as needed for your stack |

---

## How to Enable in VS Code

1. Open VS Code
2. Install the **GitHub Copilot** extension (if not already installed)
3. Open the command palette: `Ctrl+Shift+P` / `Cmd+Shift+P`
4. Run: **"GitHub Copilot: Enable"**
5. The instruction files are picked up automatically — no configuration needed

To verify instructions are active: open Copilot Chat, type anything, and check the gear icon → the instructions should appear in the context.

---

## How to Use the Prompts

In Copilot Chat, type `/` followed by the prompt name:

```
/plan        → plan a feature before writing code
/tdd         → test-driven development workflow
/code-review → structured review with severity ratings
/explain     → explain selected code
/commit      → generate a conventional commit message
/debug       → systematic debugging workflow
/scaffold    → scaffold a new module/feature
/refactor    → clean up without changing behavior
/security-review → OWASP-based security audit
```

---

## How to Customize

Edit `.github/copilot-instructions.md` directly to add team-specific rules at the bottom:

```markdown
## Team-Specific Rules

- Use our internal `ApiClient` class — never raw `fetch()` calls
- All database queries go through `src/db/query.ts` — no direct Prisma imports in routes
- Feature flags via `featureFlag('name')` from `src/lib/flags.ts`
```

These additions are applied to every request, same as the base rules.

---

## What Each File Does

| File | Applies when |
|------|-------------|
| `copilot-instructions.md` | Every Copilot request, always |
| `typescript.instructions.md` | Any `.ts` or `.tsx` file is open |
| `python.instructions.md` | Any `.py` file is open |
| `react.instructions.md` | Any `.tsx` or component file |
| `api.instructions.md` | Any file in `api/`, `routes/`, `controllers/` |
| `tests.instructions.md` | Any test or spec file |
| `sql.instructions.md` | Any `.sql` or migration file |
| `docker.instructions.md` | Any Dockerfile or docker-compose file |
| `frontend-aesthetics.instructions.md` | TSX, CSS, component files |
