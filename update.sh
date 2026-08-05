#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"
CHECK_ONLY=0

usage() {
  cat <<'USAGE'
Usage: ./update.sh [--check]

Options:
  --check  Fetch origin/main and report whether updates are available without installing.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check) CHECK_ONLY=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "unknown option: $1" >&2; usage; exit 2 ;;
  esac
  shift
done

if [[ ! -d .git ]]; then
  echo "update.sh requires a git clone. For ZIP installs, download the latest ZIP and run ./install.sh again." >&2
  exit 1
fi

echo "Fetching latest Frontend Token Trim Skillpack..."
git fetch origin main

LOCAL="$(git rev-parse HEAD)"
REMOTE="$(git rev-parse origin/main)"

if [[ "$LOCAL" != "$REMOTE" ]]; then
  echo "Update available: $LOCAL -> $REMOTE"
  if (( CHECK_ONLY == 1 )); then
    exit 0
  fi
  git pull --ff-only origin main
else
  echo "Repo already up to date: $LOCAL"
  if (( CHECK_ONLY == 1 )); then
    exit 0
  fi
fi

echo
exec "$ROOT/install.sh"
