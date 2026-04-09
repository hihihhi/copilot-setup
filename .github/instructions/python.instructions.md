---
applyTo: "**/*.py"
---

# Python Rules

## Version & Style
- Python 3.10+ features allowed: `match`/`case`, union types with `|`, `str | None`.
- Type hints on all function signatures — inputs and return type.
- Use `from __future__ import annotations` for forward references.
- f-strings over `.format()` and `%` — always.
- List comprehensions over `map()`/`filter()` for readability.

## Path & File Operations
```python
# Always pathlib — never os.path
from pathlib import Path

config_path = Path(__file__).parent / 'config.json'
data = config_path.read_text(encoding='utf-8')

# Context manager for all file I/O
with open(Path('data.csv'), encoding='utf-8') as f:
    content = f.read()
```

## Data Structures
Use `dataclasses` or `pydantic` for structured data — avoid plain dicts:
```python
from dataclasses import dataclass
from typing import Optional

@dataclass(frozen=True)   # frozen = immutable after creation
class User:
    id: str
    email: str
    name: Optional[str] = None
```
Use pydantic for data that needs validation/parsing (API responses, config):
```python
from pydantic import BaseModel, EmailStr

class UserRequest(BaseModel):
    email: EmailStr
    name: str
    age: int
```

## Error Handling
```python
# No bare except — always catch specific exceptions
try:
    result = risky_operation()
except ValueError as e:
    logger.error("Invalid input: %s", e)
    raise
except OSError as e:
    raise RuntimeError(f"File operation failed: {e}") from e

# Use custom exceptions for domain errors
class UserNotFoundError(Exception):
    def __init__(self, user_id: str) -> None:
        super().__init__(f"User {user_id!r} not found")
        self.user_id = user_id
```

## Logging
```python
import logging

logger = logging.getLogger(__name__)  # module-level logger, not root

# Use % formatting in log calls — lazy evaluation, faster if log level is off
logger.info("Processing user %s", user_id)
logger.error("Failed: %s", err, exc_info=True)  # exc_info attaches traceback

# Never: print() in library/service code
# Never: logging.basicConfig() in a module — only in __main__
```

## Functions & Modules
- Functions do one thing. If a function name has "and" in it, split it.
- `context managers` (`with`) for DB connections, locks, temp files — always.
- Module-level code that has side effects → wrap in `if __name__ == '__main__':`.

## Virtual Environments & Packages
- Assume `uv` if available in the project, else `pip` in a venv.
- Check `requirements.txt` or `pyproject.toml` before suggesting a package.
- If a package isn't listed, say: "This requires `X` — add it to requirements."

## Testing (pytest)
```python
# Test names: describe behavior
def test_returns_404_when_user_not_found():
    ...

# One assertion per test concept
# Fixtures for shared setup — avoid module-level mutable state
# Use tmp_path fixture for temp files — never hardcode /tmp
```

## Common Anti-Patterns
```python
# 1. Mutable default arguments
def add(item, lst=[]):  # shared across all calls!
    lst.append(item)
# Fix: def add(item, lst=None): lst = lst or []

# 2. Star import
from module import *  # pollutes namespace, breaks tools
# Fix: import explicitly

# 3. String path concatenation
path = base_dir + '/' + filename  # breaks on Windows
# Fix: Path(base_dir) / filename

# 4. Catching and ignoring
except Exception:
    pass  # silently swallows errors
# Fix: at minimum, log and re-raise or return an error value
```
