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

# Ponytail has moved its canonical skill file between releases. Prefer the
# native skill path, then fall back to the agent-rule path used by older
# releases. Refuse ambiguous or unsupported layouts instead of syncing a
# README or unrelated prompt by accident.
candidates=(
  "$tmp/ponytail/skills/ponytail/SKILL.md"
  "$tmp/ponytail/.openclaw/skills/ponytail/SKILL.md"
  "$tmp/ponytail/.agents/rules/ponytail.md"
)
matching=()
for candidate in "${candidates[@]}"; do
  if [[ -L "$candidate" ]]; then
    echo "Supported upstream skill path is a symlink; refusing automatic content sync: $candidate" >&2
    exit 1
  fi
  if [[ -f "$candidate" ]]; then
    matching+=("$candidate")
  fi
done

if (( ${#matching[@]} == 0 )); then
  echo "Upstream clone has no supported ponytail skill path; refusing automatic content sync." >&2
  echo "Checked: skills/ponytail/SKILL.md, .openclaw/skills/ponytail/SKILL.md, .agents/rules/ponytail.md" >&2
  exit 1
fi
if (( ${#matching[@]} > 1 )); then
  printf 'Multiple supported upstream ponytail skill paths found; refusing automatic content sync:\n' >&2
  printf '  %s\n' "${matching[@]}" >&2
  exit 1
fi
upstream_skill="${matching[0]}"
upstream_skill_dir="$(dirname "$upstream_skill")"

backup="$tmp/current-ponytail"
cp -R "$PONYTAIL_DEST" "$backup"
mkdir -p "$PONYTAIL_DEST"
cp -R "$upstream_skill" "$PONYTAIL_DEST/SKILL.md"
for dir in references templates scripts assets; do
  source_dir=""
  for candidate_dir in "$upstream_skill_dir/$dir" "$tmp/ponytail/$dir"; do
    if [[ -d "$candidate_dir" && ! -L "$candidate_dir" ]]; then
      source_dir="$candidate_dir"
      break
    fi
  done
  if [[ -n "$source_dir" ]]; then
    mkdir -p "$PONYTAIL_DEST/$dir"
    cp -R "$source_dir/." "$PONYTAIL_DEST/$dir/"
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
