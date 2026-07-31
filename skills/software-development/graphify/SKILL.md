---
name: graphify
description: Use when a codebase task needs context narrowed before implementation. Builds a small dependency/path map so the agent reads and edits only the files connected to the requested behavior.
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [codebase, context, graph, frontend, debugging]
    related_skills: [ponytail, systematic-debugging]
---

# Graphify

## Overview

Graphify is a context-control skill: turn a vague codebase request into a small working graph before reading broadly or editing. The graph is not a full architecture diagram. It is the minimum chain that explains the requested behavior.

Default shape:

```txt
entry/route → component/function → data/API/state dependency → style/token dependency → QA target
```

The goal is lower token use and fewer wrong edits: read the connected path, not the whole repo.

## When to Use

- Frontend route/component bugs, UI polish, API-backed screens, or responsive issues.
- Backend or full-stack tasks where a symptom appears in one place but the root cause may sit one or two hops away.
- Large repos where opening whole directories would waste context.
- Any task where the next file to read is unclear.

Don't use for tiny single-file edits where the relevant file is already known.

## Workflow

1. **Anchor the entry.** Search for the route, visible copy, component name, API endpoint, CSS class, or test name. Completion criterion: one likely entry file is identified.
2. **Trace one hop out.** Read imports/callers around the entry: direct child components, shared hooks, API clients, server actions, CSS/modules/tokens. Completion criterion: every next file has a direct edge from the entry.
3. **Make the path map.** State the path in one line before editing. Completion criterion: `entry → dependency → QA target` is explicit.
4. **Stop expanding early.** Only open sibling examples if the existing path lacks a clear pattern. Completion criterion: no file is read “just in case.”
5. **Edit the narrowest node.** Prefer the shared/root node when it fixes all affected callers; otherwise patch the exact leaf. Completion criterion: the edit location explains the symptom without broad rewrite.
6. **Verify on the graph.** Test the route/component/state path that was mapped. Completion criterion: the same path that justified the edit is exercised.

## Reading Rules

- Use targeted searches and small read windows before full files.
- Prefer entry files, direct imports, and existing patterns over repo-wide browsing.
- Do not paste large raw search results into final output; summarize the graph and evidence.
- If the graph grows beyond ~5 nodes, split the task or name the uncertainty before continuing.

## Frontend Graph Examples

```txt
/app/(member)/program/page.tsx → ProgramViewer → useAssignedPrograms → program card CSS → /program at 390px
```

```txt
/src/app/api/wods/route.ts → wodService.create → WodForm → shared Button/Input tokens → manager WOD creation flow
```

## Common Pitfalls

1. **Reading by folder instead of edge.** `components/` may contain hundreds of irrelevant files. Follow imports/callers.
2. **Stopping at the symptom leaf.** If three screens share the broken helper, fix the helper, not all leaves.
3. **Graphing forever.** The graph is a working map, not documentation. Stop once it tells you where to edit and verify.
4. **Ignoring styles/data edges.** Frontend defects often cross component + CSS/token + API state. Include the smallest relevant style/data dependency.

## Verification Checklist

- [ ] Entry file identified by search or user-provided path.
- [ ] Direct imports/callers traced one hop out.
- [ ] One-line graph stated before edit.
- [ ] No broad directory reading without a graph edge.
- [ ] Edit happened at the narrowest node that explains the behavior.
- [ ] Verification exercised the mapped path.
