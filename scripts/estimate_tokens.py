#!/usr/bin/env python3
"""Estimate token counts for one or more transcript files.

Exact token usage depends on the provider/model. This script uses tiktoken when
available and falls back to a conservative character-based estimate.
"""

from __future__ import annotations

import sys
from pathlib import Path


def estimate(text: str) -> tuple[int, str]:
    try:
        import tiktoken  # type: ignore

        enc = tiktoken.get_encoding("cl100k_base")
        return len(enc.encode(text)), "tiktoken:cl100k_base"
    except Exception:
        # Conservative mixed-language fallback. English often averages ~4 chars/token,
        # CJK can be closer to 1-2 chars/token. Use 3 chars/token to avoid undercounting.
        return max(1, round(len(text) / 3)), "chars/3 fallback"


def main(argv: list[str]) -> int:
    if not argv:
        print("usage: estimate_tokens.py <transcript-or-log> [...]")
        return 2

    rows = []
    for raw in argv:
        path = Path(raw)
        text = path.read_text(encoding="utf-8")
        tokens, method = estimate(text)
        rows.append((path, len(text), tokens, method))

    print("file,chars,estimated_tokens,method")
    for path, chars, tokens, method in rows:
        print(f"{path},{chars},{tokens},{method}")

    if len(rows) == 2:
        base = rows[0][2]
        trim = rows[1][2]
        delta = trim - base
        pct = (delta / base * 100) if base else 0
        print()
        print(f"baseline={base}")
        print(f"token_trim={trim}")
        print(f"delta={delta} ({pct:+.1f}%)")

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
