#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
usage() {
  cat <<'USAGE'
Usage:
  scripts/install-agent-rules.sh <codex|claude|openclaude|generic> <project-dir> [--append|--force]

Examples:
  scripts/install-agent-rules.sh codex ~/my-app
  scripts/install-agent-rules.sh claude ~/my-app --append
  scripts/install-agent-rules.sh openclaude ~/my-app --force

Default behavior refuses to overwrite an existing target file.
--append appends the rule under a Frontend Token Trim section.
--force backs up the existing file and replaces it.
USAGE
}

mode="${1:-}"
project="${2:-}"
flag="${3:-}"
[[ -n "$mode" && -n "$project" ]] || { usage; exit 2; }
[[ "$flag" == "" || "$flag" == "--append" || "$flag" == "--force" ]] || { usage; exit 2; }

case "$mode" in
  codex) src="$ROOT/templates/AGENTS.md"; target="AGENTS.md" ;;
  claude) src="$ROOT/templates/CLAUDE.md"; target="CLAUDE.md" ;;
  openclaude) src="$ROOT/templates/OPENCLAUDE.md"; target="OPENCLAUDE.md" ;;
  generic) src="$ROOT/templates/frontend-token-trim.md"; target="FRONTEND_TOKEN_TRIM.md" ;;
  *) usage; exit 2 ;;
esac

[[ -f "$src" ]] || { echo "missing template: $src" >&2; exit 1; }
mkdir -p "$project"
dest="$project/$target"
stamp="$(date +%Y%m%d-%H%M%S)"

if [[ -e "$dest" ]]; then
  case "$flag" in
    --append)
      {
        printf '\n\n<!-- Frontend Token Trim: appended %s -->\n\n' "$stamp"
        cat "$src"
      } >> "$dest"
      echo "appended: $dest"
      ;;
    --force)
      cp "$dest" "$dest.backup-$stamp"
      cp "$src" "$dest"
      echo "backup: $dest.backup-$stamp"
      echo "installed: $dest"
      ;;
    *)
      echo "refusing to overwrite existing file: $dest" >&2
      echo "Use --append or --force." >&2
      exit 1
      ;;
  esac
else
  cp "$src" "$dest"
  echo "installed: $dest"
fi
