---
applyTo: "**/*.py"
---

# Python Rules

- Python 3.10+ features allowed (match/case, union types with `|`).
- Type hints on all function signatures. Use `from __future__ import annotations` for forward refs.
- `pathlib.Path` over `os.path` for file operations.
- `dataclasses` or `pydantic` for data structures — avoid plain dicts for structured data.
- Context managers (`with`) for file I/O, database connections, locks.
- List comprehensions over `map()`/`filter()` for readability.
- f-strings over `.format()` and `%` formatting.
- `logging` module — never `print()` for diagnostic output in library/service code.
- Virtual environments: assume `uv` if available, else `pip` in a venv.
- Tests: `pytest` preferred. Each test function tests one thing.
- No bare `except:` — catch specific exceptions. `except Exception as e:` at minimum.
