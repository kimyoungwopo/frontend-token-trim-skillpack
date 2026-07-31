#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT/skills/software-development"
DEST="${HERMES_SKILLS_DIR:-$HOME/.hermes/skills/software-development}"
STAMP="$(date +%Y%m%d-%H%M%S)"

skills=(ponytail graphify headroom frontend-token-trim)

mkdir -p "$DEST"

for skill in "${skills[@]}"; do
  if [[ ! -f "$SRC/$skill/SKILL.md" ]]; then
    echo "missing bundled skill: $skill" >&2
    exit 1
  fi

done

for skill in "${skills[@]}"; do
  if [[ -e "$DEST/$skill" ]]; then
    mv "$DEST/$skill" "$DEST/$skill.backup-$STAMP"
    echo "backup: $DEST/$skill.backup-$STAMP"
  fi
  cp -R "$SRC/$skill" "$DEST/$skill"
  echo "installed: $skill"
done

cat <<MSG

Done. Start a new Hermes session, then use:
  frontend-token-trim 적용해서 프론트엔드 작업해줘.

Installed to:
  $DEST
MSG
