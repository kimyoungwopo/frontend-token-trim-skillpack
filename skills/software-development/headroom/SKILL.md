---
name: headroom
description: Use when a task risks wasting context or output budget. Reserves token headroom for verification, repair, and final evidence by compressing inputs, tool output, and reports.
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [context, tokens, reporting, verification]
    related_skills: [graphify, ponytail]
---

# Headroom

## Overview

Headroom is the discipline of leaving enough context budget for the part that usually matters most: verification and repair. It reduces token use by avoiding raw dumps, long speculative plans, and final essays, while preserving the evidence needed to trust the result.

Headroom does **not** mean skipping checks. It means spending tokens where they change the outcome.

## When to Use

- Long frontend/codebase tasks with many files or screenshots.
- Reviews where raw diffs/logs/search results could flood context.
- Agent delegation prompts that need to stay compact but verifiable.
- Any task where previous attempts ran out of context or over-reported.

Don't use to hide uncertainty, omit real failures, or skip source inspection.

## Budget Rules

1. **Spend first on anchors.** Keep the user request, exact target route/file, failing symptom, and acceptance criteria visible.
2. **Compress discovery.** Convert search results into a small file map instead of pasting everything.
3. **Prefer windows and diffs.** Read line windows or bundles only as needed; avoid whole-file dumps when a function/component is enough.
4. **Keep output short until verified.** Do not write long explanations before the code/test/browser state is known.
5. **Reserve final tokens for evidence.** Final report should include changed files, commands/checks run, pass/fail, screenshots/viewport notes when relevant, and remaining risk.

## Practical Report Shape

Use this final shape for Korean frontend work:

```txt
완료: <사용자 관점 결과>
변경: <파일 1-3개 또는 핵심 diff>
검증: <명령/브라우저/뷰포트 + 결과>
리스크: <남은 것 없으면 없음>
```

## Tool Output Compression

- Large `search_files`: report matching files + why they matter.
- Large test output: report command, exit code, failing test names, first actionable error.
- Browser QA: report viewport, route, overflow/console state, screenshot path if useful.
- Git diff: report file list and behavior change, not every hunk, unless user asks.

## Stop Conditions

Pause and re-plan if:

- You are about to read an unrelated directory.
- You cannot state why the next file matters.
- Final response would be longer than the evidence.
- The task is expanding into a refactor not requested by the user.

## Common Pitfalls

1. **Premature summarizing.** A concise claim without verification is not headroom; it is guessing.
2. **Raw-dump final answers.** The user needs outcome and evidence, not logs pasted wholesale.
3. **Over-compressing errors.** Keep exact failing command/error when it blocks completion.
4. **Saving no space for screenshots/QA.** Visual frontend tasks need evidence after implementation, not only code diffs.

## Verification Checklist

- [ ] Large discovery output was compressed into a file/path map.
- [ ] Whole files/logs were avoided unless necessary.
- [ ] Verification evidence was preserved.
- [ ] Final answer is concise and includes result, evidence, risk.
- [ ] No uncertainty or blocker was hidden for brevity.
