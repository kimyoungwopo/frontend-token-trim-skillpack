#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PONYTAIL_REPO="${PONYTAIL_REPO:-https://github.com/DietrichGebert/ponytail.git}"
PONYTAIL_DEST="$ROOT/skills/software-development/ponytail"
UPSTREAM_DIR="$ROOT/.upstream"
HEAD_FILE="$UPSTREAM_DIR/ponytail.head"
MODE="${1:---check}"

mkdir -p "$UPSTREAM_DIR"

tmp="$(mktemp -d)"
cleanup() { rm -rf "$tmp"; }
trap cleanup EXIT

echo "Checking ponytail upstream: $PONYTAIL_REPO"
git clone --depth 1 "$PONYTAIL_REPO" "$tmp/ponytail" >/dev/null 2>&1
new_head="$(git -C "$tmp/ponytail" rev-parse HEAD)"
old_head="$(cat "$HEAD_FILE" 2>/dev/null || true)"

echo "upstream_head=$new_head"
if [[ -n "$old_head" ]]; then
  echo "recorded_head=$old_head"
fi

if [[ "$new_head" == "$old_head" ]]; then
  echo "No upstream ponytail change."
  exit 0
fi

if [[ "$MODE" == "--check" ]]; then
  echo "Upstream ponytail changed. Run: scripts/sync-upstream-skills.sh --apply"
  exit 2
fi

if [[ "$MODE" != "--apply" ]]; then
  echo "Usage: $0 [--check|--apply]" >&2
  exit 64
fi

source_file=""
source_kind=""
if [[ -f "$tmp/ponytail/SKILL.md" ]]; then
  source_file="$tmp/ponytail/SKILL.md"
  source_kind="skill"
elif [[ -f "$tmp/ponytail/.agents/rules/ponytail.md" ]]; then
  source_file="$tmp/ponytail/.agents/rules/ponytail.md"
  source_kind="agent-rule"
elif [[ -f "$tmp/ponytail/AGENTS.md" ]]; then
  source_file="$tmp/ponytail/AGENTS.md"
  source_kind="agents-md"
else
  echo "Upstream clone does not contain a supported ponytail source (SKILL.md, .agents/rules/ponytail.md, or AGENTS.md)." >&2
  exit 1
fi

backup="$tmp/current-ponytail"
cp -R "$PONYTAIL_DEST" "$backup"
rm -rf "$PONYTAIL_DEST"
mkdir -p "$PONYTAIL_DEST"

if [[ "$source_kind" == "skill" ]]; then
  cp -R "$source_file" "$PONYTAIL_DEST/SKILL.md"
else
  cat > "$PONYTAIL_DEST/SKILL.md" <<EOF
---
name: ponytail
description: "Use when writing or changing code where the user wants the simplest correct implementation: YAGNI, reuse existing code, standard library/native features first, no unrequested abstractions, shortest working diff after understanding the real flow."
version: upstream-${new_head:0:7}
author: Dietrich Gebert / Frontend Token Trim Skillpack adaptation
license: MIT
metadata:
  hermes:
    tags: [coding, yagni, minimalism, frontend, refactoring]
    related_skills: [systematic-debugging, test-driven-development, requesting-code-review, codex]
---

EOF
  cat "$source_file" >> "$PONYTAIL_DEST/SKILL.md"
fi

for dir in references templates scripts assets; do
  if [[ "$source_kind" == "skill" && -d "$tmp/ponytail/$dir" ]]; then
    cp -R "$tmp/ponytail/$dir" "$PONYTAIL_DEST/$dir"
  elif [[ -d "$backup/$dir" ]]; then
    cp -R "$backup/$dir" "$PONYTAIL_DEST/$dir"
  fi
done

# Keep an explicit adaptation/source line if upstream omitted one.
if ! grep -qi '^license: MIT\|Source: .*DietrichGebert/ponytail' "$PONYTAIL_DEST/SKILL.md"; then
  cat >> "$PONYTAIL_DEST/SKILL.md" <<'NOTE'

## Distribution note

Source: https://github.com/DietrichGebert/ponytail (MIT). Bundled by Frontend Token Trim Skillpack.
NOTE
fi

printf '%s\n' "$new_head" > "$HEAD_FILE"

echo "Applied upstream ponytail update from $source_kind. Review git diff before merging."
