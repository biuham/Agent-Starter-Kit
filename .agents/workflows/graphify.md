---
name: graphify
description: Turn any folder of files into a navigable knowledge graph
---

# Workflow: graphify

For an explicit `/graphify` request, load the installed Graphify skill and follow its supported workflow. Check the harness skill catalog: the skill may be installed globally rather than in `.agents/skills`.

If the skill is unavailable, inspect `graphify --help` (or `python -m graphify --help` when only the Python module is installed) and use only supported commands. If neither is available, report the missing prerequisite; continue ordinary code investigation with scoped search instead of claiming a graph was built.

If no path argument is given, use `.` (current directory).
