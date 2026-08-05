#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="${HERMES_SKILLS_DIR:-$HOME/.hermes/skills/software-development}"
BACKUP_ROOT="${HERMES_SKILL_BACKUP_DIR:-$HOME/.hermes/skill-backups/frontend-token-trim/software-development}"
skills=(ponytail graphify headroom frontend-token-trim)
templates=(AGENTS.md CLAUDE.md OPENCLAUDE.md frontend-token-trim.md)
status=0

ok() { printf '✓ %s\n' "$1"; }
warn() { printf '! %s\n' "$1"; }
fail() { printf '✗ %s\n' "$1"; status=1; }

printf 'Frontend Token Trim Doctor\n\n'

[[ -d "$ROOT/.git" ]] && ok "git clone detected" || warn "not a git clone; update.sh will not work for ZIP installs"
[[ -x "$ROOT/install.sh" ]] && ok "install.sh executable" || fail "install.sh is not executable"
[[ -x "$ROOT/update.sh" ]] && ok "update.sh executable" || warn "update.sh is not executable"

for skill in "${skills[@]}"; do
  [[ -f "$ROOT/skills/software-development/$skill/SKILL.md" ]] && ok "bundled skill found: $skill" || fail "missing bundled skill: $skill"
  [[ -f "$DEST/$skill/SKILL.md" ]] && ok "installed skill found: $skill" || warn "installed skill missing: $skill"
done

shopt -s nullglob
active_backups=("$DEST"/*.backup-*)
if (( ${#active_backups[@]} == 0 )); then
  ok "no backup skill dirs inside active skill discovery"
else
  fail "backup skill dirs inside active skill discovery: ${#active_backups[@]}"
  printf '  move them to: %s\n' "$BACKUP_ROOT"
fi

for tpl in "${templates[@]}"; do
  [[ -f "$ROOT/templates/$tpl" ]] && ok "template found: $tpl" || fail "missing template: $tpl"
done

[[ -f "$ROOT/skillpack.json" ]] && ok "skillpack.json found" || fail "missing skillpack.json"
[[ -f "$ROOT/docs/modes.md" ]] && ok "modes docs found" || warn "docs/modes.md missing"
[[ -f "$ROOT/docs/frontend-qa-checklist.md" ]] && ok "frontend QA checklist found" || warn "docs/frontend-qa-checklist.md missing"

if command -v git >/dev/null && [[ -d "$ROOT/.git" ]]; then
  current="$(git -C "$ROOT" rev-parse --short HEAD 2>/dev/null || true)"
  branch="$(git -C "$ROOT" rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
  ok "repo branch: ${branch:-unknown} @ ${current:-unknown}"
fi

printf '\n'
if (( status == 0 )); then
  printf 'Ready. Start a new Hermes session after install/update.\n'
else
  printf 'Doctor found issues. Fix the failed items above.\n' >&2
fi
exit "$status"
