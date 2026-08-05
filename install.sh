#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT/skills/software-development"
DEST="${HERMES_SKILLS_DIR:-$HOME/.hermes/skills/software-development}"
BACKUP_ROOT="${HERMES_SKILL_BACKUP_DIR:-$HOME/.hermes/skill-backups/frontend-token-trim/software-development}"
STAMP="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0
FORCE=0

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--dry-run] [--force]

Options:
  --dry-run  Show what would be installed/backed up without writing files.
  --force    Reserved for explicit overwrite intent; current installer always backs up existing skills before replacing.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    --force) FORCE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "unknown option: $1" >&2; usage; exit 2 ;;
  esac
  shift
done

skills=(ponytail graphify headroom frontend-token-trim)

for skill in "${skills[@]}"; do
  if [[ ! -f "$SRC/$skill/SKILL.md" ]]; then
    echo "missing bundled skill: $skill" >&2
    exit 1
  fi
done

if (( DRY_RUN == 1 )); then
  echo "Frontend Token Trim install dry run"
  echo "Install destination: $DEST"
  echo "Backup destination:  $BACKUP_ROOT"
  for skill in "${skills[@]}"; do
    if [[ -e "$DEST/$skill" ]]; then
      echo "would backup: $DEST/$skill -> $BACKUP_ROOT/$skill.backup-$STAMP"
    fi
    echo "would install: $skill"
  done
  exit 0
fi

mkdir -p "$DEST" "$BACKUP_ROOT"

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
