# copilot-setup

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)

**One-command GitHub Copilot configuration harness for enterprise teams.**
Zero dependencies. Works fully air-gapped. Pure file copy — no npm, no Python, no internet required.

---

## What This Does

Installs a curated set of configuration files into any repository that makes GitHub Copilot
behave more consistently, more carefully, and more usefully:

| File | What it does |
|------|-------------|
| `.github/copilot-instructions.md` | Core behavioral contract — always applied to every Copilot request |
| `.github/instructions/*.instructions.md` | Path-scoped rules — TypeScript, Python, React, API, SQL, Docker, Tests |
| `.github/prompts/*.prompt.md` | Reusable slash commands — `/code-review`, `/security-review`, `/tdd`, `/debug`, `/deep-research`, `/prd-to-plan`, `/refactor` |
| `.vscode/settings.json` | Workspace defaults — instruction injection for code, test, review, commit |

Commit these files into your repository. Every developer on the team gets the same baseline behavior automatically.

---

## Install

**Unix / Git Bash / macOS / Linux:**
```bash
git clone <this-repo>
cd copilot-setup
./install.sh --target /path/to/your/project
```

**Windows PowerShell:**
```powershell
git clone <this-repo>
cd copilot-setup
.\install.ps1 -Target C:\path\to\your\project
```

Then commit the installed files:
```bash
git add .github/ .vscode/settings.json
git commit -m "chore: install copilot-setup configuration harness"
```

---

## Available Prompt Commands

Type `/name` in Copilot Chat to invoke:

| Command | What it does |
|---------|-------------|
| `/code-review` | Structured review: correctness, security, performance, maintainability |
| `/security-review` | OWASP Top 10 audit with severity ratings and remediation |
| `/tdd` | Test-first development — write failing tests before implementation |
| `/debug` | Systematic debugging: reproduce → isolate → hypothesize → fix → verify |
| `/deep-research` | 5-stage research pipeline with anti-sycophancy guards |
| `/prd-to-plan` | Convert requirements into vertical slices with acceptance criteria |
| `/refactor` | Surgical refactoring without changing behavior |

---

## Path-Scoped Instructions

These apply **automatically** when Copilot works with matching files:

| File | Applies to |
|------|-----------|
| `typescript.instructions.md` | `**/*.ts`, `**/*.tsx` |
| `python.instructions.md` | `**/*.py` |
| `react.instructions.md` | `**/*.tsx`, `**/components/**` |
| `api.instructions.md` | `**/api/**`, `**/routes/**`, `**/controllers/**` |
| `tests.instructions.md` | `**/*.test.*`, `**/*.spec.*`, `**/tests/**` |
| `sql.instructions.md` | `**/*.sql`, `**/migrations/**` |
| `docker.instructions.md` | `**/Dockerfile*`, `**/docker-compose*.yml` |

---

## What's Different From Claude Code

| Claude Code | Copilot Enterprise |
|-------------|-------------------|
| `~/.claude/CLAUDE.md` | `.github/copilot-instructions.md` |
| Skills (SKILL.md files) | `.github/prompts/*.prompt.md` |
| Path-scoped rules | `.github/instructions/*.instructions.md` |
| PreToolUse hooks | Not available |
| Memory system (3-tier) | Not available — stateless per session |
| Agent orchestration | Not available |
| MCP servers | Not available in air-gapped environments |

Copilot in enterprise is fundamentally stateless and hookless. Everything has to be encoded
in instructions and prompts. What you lose in programmability you gain in simplicity — these
are plain markdown files that work everywhere Copilot is available.

---

## Customizing Per Role

The `.github/copilot-instructions.md` is a shared baseline. For role-specific teams:

1. Edit `.github/copilot-instructions.md` directly — add role-specific rules at the bottom
2. Or maintain a separate branch per team with different instruction files

**Suggested customizations by role:**
- **Backend / API teams**: add API versioning standards, preferred frameworks, database conventions
- **Frontend teams**: add component library rules, accessibility requirements, CSS methodology
- **Data / ML teams**: add notebook conventions, data validation requirements, model documentation standards
- **Security teams**: add mandatory security review checklist items, compliance requirements

---

## License

MIT
