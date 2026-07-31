# Token Usage Benchmark

[← README](../README.md) · [한국어](ko.md) · [English](en.md) · [日本語](ja.md)

## Can you compare token usage with vs without this skillpack?

Yes. The reliable way is to run the **same frontend task twice** and compare actual usage from the agent/provider logs.

```txt
A. Baseline: normal frontend task prompt
B. Token Trim: same task + Frontend Token Trim contract
```

Then compare:

| Metric | What it shows |
|---|---|
| Input tokens | How much repo/context/log content the agent consumed |
| Output tokens | How much explanation/code/report text the agent produced |
| Total tokens | Overall cost |
| Tool calls | Whether the agent browsed broadly or stayed narrow |
| Files read | Biggest signal for Graphify savings |
| Files changed | Biggest signal for Ponytail savings |
| Verification evidence | Guardrail: token savings must not remove QA |
| Rework turns | Whether Headroom saved enough context for repair |

## Expected pattern

This skillpack usually reduces tokens by reducing **unnecessary context**, not by making the initial prompt shorter.

Typical savings are highest when the repo is large or the issue is localized:

| Task type | Expected savings | Why |
|---|---:|---|
| Small single-file known fix | Low | There is little browsing to eliminate |
| Route/component bug in medium repo | Medium | Graphify avoids unrelated component reads |
| Mobile visual defect | Medium | Narrow selector fixes avoid broad redesign |
| Large app with unclear ownership | High | Path mapping prevents repo-wide exploration |
| New feature with broad unclear scope | Variable | Savings depend on how much scope can be narrowed |

## Benchmark prompt pair

### A. Baseline

```txt
Fix this frontend issue: <same task details>
Verify the result and report what changed.
```

### B. Frontend Token Trim

```txt
Fix this frontend issue: <same task details>

Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```

## How to count

### Best: provider or agent usage logs

Use actual usage from your agent/provider if available. That is the only exact comparison because tokenization differs by model.

Record:

```txt
model:
input_tokens:
output_tokens:
total_tokens:
tool_calls:
files_read:
files_changed:
checks_run:
```

### Good fallback: transcript/context estimate

If you only have transcript text, use the included estimator:

```bash
python3 scripts/estimate_tokens.py baseline-transcript.txt token-trim-transcript.txt
```

The fallback estimator is approximate. It uses `tiktoken` if installed; otherwise it uses a conservative character-based estimate.

## Suggested CSV format

```csv
run,mode,model,input_tokens,output_tokens,total_tokens,tool_calls,files_read,files_changed,checks_run,result
1,baseline,,,,,,,,,
1,frontend-token-trim,,,,,,,,,
```

## Valid comparison rules

- Use the same model family when possible.
- Use the same starting commit.
- Reset the working tree between runs.
- Use the same task wording except for the Token Trim contract.
- Require the same acceptance criteria and verification gates.
- Do not count a run as better if it saved tokens by skipping required QA.

## Interpreting results

Good outcome:

```txt
Lower total tokens + same or better verification + fewer files read/changed
```

Bad outcome:

```txt
Lower tokens only because QA, source inspection, or error reporting was skipped
```

The goal is not minimum tokens at any cost. The goal is **fewer wasted tokens per verified frontend fix**.
