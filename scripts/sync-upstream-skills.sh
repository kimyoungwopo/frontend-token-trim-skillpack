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

if [[ ! -f "$tmp/ponytail/SKILL.md" ]]; then
  echo "Upstream clone does not contain SKILL.md; refusing automatic content sync." >&2
  exit 1
fi

backup="$tmp/current-ponytail"
cp -R "$PONYTAIL_DEST" "$backup"
rm -rf "$PONYTAIL_DEST"
mkdir -p "$PONYTAIL_DEST"
cp -R "$tmp/ponytail/SKILL.md" "$PONYTAIL_DEST/SKILL.md"
for dir in references templates scripts assets; do
  if [[ -d "$tmp/ponytail/$dir" ]]; then
    cp -R "$tmp/ponytail/$dir" "$PONYTAIL_DEST/$dir"
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

echo "Applied upstream ponytail update. Review git diff before merging."
