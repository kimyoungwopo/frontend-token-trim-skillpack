# Examples

[← README](../README.md) · [Benchmark](benchmark.md)

## Frontend bug fix prompt

```txt
Fix the dashboard card overflow on mobile.

Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```

Expected agent behavior:

```txt
/dashboard → DashboardCard → dashboard.css → 320/390px QA
```

## UI polish prompt

```txt
Polish the pricing card spacing without changing the design system.
Use frontend-token-trim. Reuse existing tokens and verify 390px mobile.
```

## Code review prompt

```txt
Review this PR with frontend-token-trim.
Focus on unnecessary file reads, new dependencies, broad refactors, mobile overflow risk, and missing verification evidence.
```

## Final report shape

```txt
완료: /dashboard 모바일 카드 overflow 수정
변경: styles/dashboard.css 한 파일
검증: lint 통과, 320px/390px overflow 없음
리스크: 다른 dashboard 섹션은 범위 밖이라 미수정
```
