---
name: frontend-token-trim
description: Use when doing frontend implementation, QA, or review where token/context cost should stay low. Combines Ponytail minimal diffs, Graphify code-path narrowing, and Headroom context/output budgeting.
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [frontend, tokens, context, qa, minimalism]
    related_skills: [ponytail, graphify, headroom, frontend-design-patterns-autolearn, frontend-api-flow-qa]
---

# Frontend Token Trim

## Overview

Use this skill to reduce real frontend token burn without reducing correctness. The rule is not “write shorter prompts.” The rule is: **touch the smallest proven code path, reuse what exists, keep context headroom, and verify the exact affected surface.**

It combines three behaviors:

- **Ponytail** — YAGNI, existing code first, shortest correct diff.
- **Graphify** — build a small dependency/path map before reading or editing broadly.
- **Headroom** — reserve context/output budget for verification and repair instead of spending it on exhaustive dumps or essays.

## When to Use

- Frontend bug fix, UI polish, route implementation, responsive repair, or code review.
- User asks for token saving, context reduction, “less bloat,” minimal implementation, or faster frontend iteration.
- Repo is large enough that reading whole directories/components would be wasteful.

Don't use as an excuse to skip source inspection, QA, accessibility, security, auth/RLS checks, or production deploy gates.

## The 3-Part Loop

### 1. Graphify: narrow the path first

Before opening many files, identify the smallest likely path:

1. Locate the route/page/component named by the user.
2. Find imports/callers one hop out: shared component, hook, API client, CSS/token file.
3. Check existing patterns near that path before creating anything.
4. Stop expanding once every file you plan to touch has a reason.

Completion criterion: you can state `route → component → data/style dependency → QA target` in one line.

Good searches:

```bash
# use search_files tool instead of shell grep when available
route name, visible Korean copy, component name, API endpoint, CSS class/token
```

Read order:

1. Entry route/page.
2. Direct child component with the visible defect/feature.
3. Existing shared component/token/hook it already uses.
4. Only then sibling examples.

### 2. Ponytail: smallest correct diff

Apply the ladder:

1. Delete or reuse before adding.
2. Existing component/token/hook before new component/token/hook.
3. Native HTML/CSS before JS/dependency.
4. One local patch before broad refactor.
5. New abstraction only when two real call sites need it now.

Completion criterion: every modified file is necessary for the exact user-visible change or its verification.

Frontend defaults:

- No new dependencies unless existing/native options cannot solve it.
- Keep accessibility: labels, focus-visible, keyboard path, contrast, 44px touch targets.
- Preserve project style and tokens; avoid isolated mini design systems.
- For Korean/mobile work, verify 320/390 overflow and Hangul fit before claiming done.

### 3. Headroom: budget context for QA and repair

Keep enough context/output room for the last mile.

Rules:

- Do not paste whole files into the conversation when a line/window or diff is enough.
- Summarize large search results as a touched-file map, not raw dumps.
- Avoid speculative plans longer than the patch.
- Save final tokens for exact verification output: command names, exit status, screenshot/viewport checks, remaining risk.
- If a task starts ballooning, pause and re-narrow the graph instead of reading more broadly.

Completion criterion: final response fits in concise Korean: result, evidence, risk, next action.

## Practical Frontend Prompt Contract

When delegating or starting frontend work, use this compact contract:

```txt
Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```

## Decision Table

| Situation | Do | Don't |
|---|---|---|
| Unknown route/component | Search visible text/route name, then read entry file | Read entire `app/` or `components/` |
| UI polish | Patch existing CSS/classes/tokens | Introduce a design system rewrite |
| Repeated pattern exists | Reuse/copy nearby project pattern | Invent new abstraction |
| Mobile defect | Capture 320/390 and patch narrow selector | Redesign whole layout blindly |
| API-backed UI | Trace existing BFF/API/client hook | Mock fake frontend-only state |
| Long tool output | Reduce to file map + evidence | Paste raw dumps into final |

## Verification Checklist

- [ ] Graphified one-line path: route → component → dependency → QA target.
- [ ] Reused existing component/token/hook/API pattern where available.
- [ ] No new dependency or broad refactor without current-path proof.
- [ ] Diff touches the fewest necessary files.
- [ ] Accessibility/security/data-integrity basics were not simplified away.
- [ ] Ran the smallest relevant check: lint/type/build/test and/or browser QA.
- [ ] For visual/mobile work, checked 320/390 overflow and visible state.
- [ ] Final report is concise Korean with changed files, evidence, risk.
