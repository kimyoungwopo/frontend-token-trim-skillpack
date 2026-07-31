# Controlled Benchmark Result

[← README](../README.md) · [Benchmark method](benchmark.md)

## Summary

This is a controlled transcript benchmark, not a provider billing log. It measures how much context is consumed when the same localized frontend issue is handled with broad browsing vs Frontend Token Trim narrowing.

Task:

```txt
Fix the mobile overflow on /dashboard at 390px. Verify the result and report what changed.
```

Tokenizer:

```txt
tiktoken:cl100k_base
```

## Result

| Mode | Estimated tokens | Characters | Files read | Files changed | Verification |
|---|---:|---:|---:|---:|---|
| Baseline broad browsing | 2,489 | 10,136 | 38 | 1 | lint, 390px browser |
| Frontend Token Trim | 496 | 1,971 | 4 | 1 | lint, 320px browser, 390px browser |

Difference:

```txt
-1,993 tokens (-80.1%)
```

## Interpretation

The savings came from **files read**, not from skipping the fix or skipping QA.

- Baseline read the route, all components, hooks, helpers, and styles before editing.
- Frontend Token Trim searched visible route/copy/class names, then read only the connected path:

```txt
/dashboard → DashboardCard → styles/dashboard.css .metric-row → QA at 320/390px
```

Both modes changed one CSS file. The Token Trim run kept more verification evidence by checking both 320px and 390px mobile widths.

## Caveats

- This is a controlled proxy benchmark, not exact OpenAI/Claude/Hermes billing data.
- Real savings depend on repo size, task ambiguity, model behavior, and available tools.
- For tiny single-file tasks, savings will be much lower.
- For large apps with unclear ownership, savings can be similar or higher.

## Reproduce locally

The generated transcripts are stored locally during the benchmark run under:

```txt
.benchmark-runs/2026-07-31-controlled/
```

Estimate again with:

```bash
python3 scripts/estimate_tokens.py \
  .benchmark-runs/2026-07-31-controlled/baseline-transcript.txt \
  .benchmark-runs/2026-07-31-controlled/token-trim-transcript.txt
```
