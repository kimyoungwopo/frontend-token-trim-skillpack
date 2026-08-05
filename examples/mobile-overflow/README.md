# Mobile Overflow Example

[← README](../../README.md) · [Modes](../../docs/modes.md) · [Frontend QA checklist](../../docs/frontend-qa-checklist.md)

This example shows how Frontend Token Trim changes a small mobile UI repair.

## Task

```txt
Fix the /dashboard card overflow on mobile and verify the result.
```

## Baseline broad behavior

```txt
read app/**
read components/**
read shared layout wrappers
inspect unrelated cards
patch one CSS file
verify only 390px
```

Typical result from the controlled transcript:

| Metric | Baseline |
|---|---:|
| Estimated tokens | 2,489 |
| Files read | 38 |
| Files changed | 1 |
| Verification | lint, 390px browser |

## Frontend Token Trim behavior

```txt
/dashboard → DashboardCard → dashboard.css → 320/390px QA
```

| Metric | Token Trim |
|---|---:|
| Estimated tokens | 496 |
| Files read | 4 |
| Files changed | 1 |
| Verification | lint, 320px + 390px browser |

## What changed

The bug is a long action row inside a card. The token-trimmed fix only adjusts the affected action row to wrap at compact widths.

See:

- [`before/dashboard-card.css`](before/dashboard-card.css)
- [`after/dashboard-card.css`](after/dashboard-card.css)

## Final report shape

```txt
Changed: dashboard-card.css
Verified: lint passed, 320px/390px no horizontal overflow
Risk: only dashboard card action row was changed; unrelated dashboard layout was not refactored
```
