# Frontend Token Trim Contract

Apply Frontend Token Trim:
1. Graphify the narrow route/component/data/style path first.
2. Reuse existing components, hooks, API clients, styles, and tokens.
3. Do not add dependencies or broad refactors unless the current path proves they are necessary.
4. Touch the fewest files that fix the real flow.
5. Verify the exact affected route plus 320/390 mobile overflow for visual work; include command/screenshot evidence.
6. Final report: changed files, verification result, remaining risk only.

Ponytail = YAGNI + existing code first + shortest correct diff.
Graphify = route/page → component → hook/API/state → style/token → QA target.
Headroom = compress discovery/output and reserve context for verification/repair.
