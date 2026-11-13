---
trigger: always_on
description: Consult the graphify knowledge graph at graphify-out/ for codebase and architecture questions.
---

## graphify

Use the knowledge graph at `graphify-out/` when available; verify its findings against current files.

Rules:
- Fast-path: When the user specifies an exact file or requests a direct/small bugfix or CSS tweak, inspect that file directly without querying graphify first.
- For codebase or architecture questions, when `graphify-out/graph.json` exists, first run `graphify query "<question>"` (CLI) or `query_graph` (MCP). Use `graphify path "<A>" "<B>"` / `shortest_path` for relationships and `graphify explain "<concept>"` / `get_node` for focused concepts. These return a scoped subgraph, usually much smaller than `GRAPH_REPORT.md` or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation; read the located source files before editing or asserting current behavior.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context
- If Graphify is unavailable, fails, or returns stale/incomplete results, continue with scoped file search and reads. Mention an unsynchronized graph only when relevant; avoid repeated failing calls.
- After completing code changes, run `graphify update .` once. Documentation-only changes need no AST update. Report an update failure without blocking unrelated work.
