#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT/skills/software-development"
DEST="${HERMES_SKILLS_DIR:-$HOME/.hermes/skills/software-development}"
BACKUP_ROOT="${HERMES_SKILL_BACKUP_DIR:-$HOME/.hermes/skill-backups/frontend-token-trim/software-development}"
STAMP="$(date +%Y%m%d-%H%M%S)"

skills=(ponytail graphify headroom frontend-token-trim)

mkdir -p "$DEST" "$BACKUP_ROOT"

for skill in "${skills[@]}"; do
  if [[ ! -f "$SRC/$skill/SKILL.md" ]]; then
    echo "missing bundled skill: $skill" >&2
    exit 1
  fi
done

for skill in "${skills[@]}"; do
  if [[ -e "$DEST/$skill" ]]; then
    backup="$BACKUP_ROOT/$skill.backup-$STAMP"
    mv "$DEST/$skill" "$backup"
    echo "backup: $backup"
  fi
  cp -R "$SRC/$skill" "$DEST/$skill"
  echo "installed: $skill"
done

cat <<MSG

Done. Start a new Hermes session, then use:
  frontend-token-trim 적용해서 프론트엔드 작업해줘.

Installed to:
  $DEST

Backups stored outside the active skills directory:
  $BACKUP_ROOT
MSG
