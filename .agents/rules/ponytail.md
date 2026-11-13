---
trigger: always_on
description: Enforce Ponytail minimalist engineering guardrail to prevent AI over-engineering and bloat.
---

## Ponytail (Minimalist Engineering Guardrail)

Active for all coding, refactoring, and architecting tasks.
Mantra: **The best code is the code never written.**

Rules:
1. **Scope discipline**: Solve the whole problem with the smallest complete change. Extra features nobody asked for are out of scope.
2. **Decision Ladder**:
   - Does it need to exist? (No -> skip it, YAGNI).
   - Is it already in this codebase? (Check via `graphify` / grep -> reuse it).
   - Does the stdlib (PHP / Dart) or browser/OS do it? (Yes -> use native platform features).
   - Does an installed dependency do it? (Yes -> use it. Never add a package for a few lines).
   - Otherwise: write the minimum clear code that works. Use one line only when it remains readable and handles the required edge cases.
3. **No Speculative Abstractions**: No wrappers, intermediate interfaces, generic factories, or "for later" boilerplate nobody asked for. Keep existing codebase conventions.
4. **Non-negotiable invariants**: Never cut validation at trust boundaries, error handling that prevents data loss, authentication/security checks, or accessibility. Apply the project's domain-specific requirements.
5. **Coordination**: Use `AGENTS.md` for project workflow, verification, and reporting; this rule supplies the engineering decision ladder, not a second workflow.
