#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

if [[ ! -d .git ]]; then
  echo "update.sh requires a git clone. For ZIP installs, download the latest ZIP and run ./install.sh again." >&2
  exit 1
fi

echo "Fetching latest Frontend Token Trim Skillpack..."
git fetch origin main

LOCAL="$(git rev-parse HEAD)"
REMOTE="$(git rev-parse origin/main)"

if [[ "$LOCAL" != "$REMOTE" ]]; then
  echo "Updating repo: $LOCAL -> $REMOTE"
  git pull --ff-only origin main
else
  echo "Repo already up to date: $LOCAL"
fi

echo
exec "$ROOT/install.sh"
