---
applyTo: "**/*.sql,**/migrations/**,**/queries/**"
---

# SQL Rules

- Explicit column lists in SELECT — no `SELECT *` in production queries.
- All queries that modify data must be wrapped in transactions.
- Parameterized queries always — never string-concatenate user input into SQL.
- Index columns used in WHERE, JOIN ON, and ORDER BY for large tables.
- Migrations: forward-only (no down migrations in production), timestamped filenames.
- Foreign keys: always define with explicit ON DELETE/ON UPDATE behavior.
- NULL handling: be explicit. `COALESCE` over implicit NULL comparisons.
- Large datasets: use `LIMIT`/pagination — never fetch unbounded result sets.
- Avoid correlated subqueries — use JOINs or CTEs for readability and performance.
- Column naming: `snake_case`, never reserved words, explicit `_id` suffix for FK columns.
