# Frontend Token Trim Modes

[← README](../README.md) · [Examples](examples.md) · [Frontend QA checklist](frontend-qa-checklist.md)

Use modes when a task needs a stronger or lighter version of the default contract.

## Light mode

Best for small UI copy, spacing, or one-file fixes.

```txt
Apply Frontend Token Trim light mode:
- Graphify only the named route/component and one direct dependency.
- Reuse existing styles/tokens.
- Touch the fewest files.
- Run the smallest relevant check.
- Final report: changed files, verification, risk.
```

## Strict mode

Best for large repos, risky UI flows, or tasks that might trigger broad browsing.

```txt
Apply Frontend Token Trim strict mode:
- Before editing, state the one-line path: route → component → data/style → QA target.
- Do not read unrelated directories.
- Do not create new dependencies, helpers, components, or abstractions unless the current path proves they are necessary.
- Verify lint/type/build or the smallest equivalent check.
- For UI changes, verify 320px and 390px overflow.
- If verification fails, re-narrow the graph before expanding scope.
```

## Review mode

Best for PR review or checking another agent's work.

```txt
Apply Frontend Token Trim review mode:
- Find over-read: files inspected without a path reason.
- Find over-change: broad refactors, new abstractions, or new deps not required by the task.
- Find missing QA: UI changes without 320/390px or command evidence.
- Final report: violations, evidence, suggested narrow repair.
```

## Choosing a mode

| Task | Recommended mode |
|---|---|
| Copy/style tweak | Light |
| Mobile overflow | Strict |
| API-backed UI bug | Strict |
| PR review | Review |
| Unknown large repo issue | Strict first, then normal after path is clear |
