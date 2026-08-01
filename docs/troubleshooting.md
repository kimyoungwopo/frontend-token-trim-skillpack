# Troubleshooting

[← README](../README.md) · [한국어](ko.md) · [English](en.md) · [日本語](ja.md)

## `frontend-token-trim` is ambiguous

Symptom:

```txt
Ambiguous skill name 'frontend-token-trim'
```

Cause: old backups were stored inside the active Hermes skills directory.

Fix:

```bash
mkdir -p ~/.hermes/skill-backups/frontend-token-trim/software-development
mv ~/.hermes/skills/software-development/*.backup-* \
  ~/.hermes/skill-backups/frontend-token-trim/software-development/ 2>/dev/null || true
cd frontend-token-trim-skillpack
./install.sh
```

Then start a new Hermes session.

## `update.sh` says this is not a git clone

`update.sh` needs `.git/` so it can pull the latest repo. If you installed from a ZIP, download the latest ZIP or clone the repo:

```bash
git clone https://github.com/kimyoungwopo/frontend-token-trim-skillpack.git
cd frontend-token-trim-skillpack
./install.sh
```

## `git pull --ff-only` fails

Your local clone has local commits or file changes.

```bash
git status --short
git stash push -m frontend-token-trim-local-changes
./update.sh
```

If you intentionally changed the pack, commit your work or use a fresh clone.

## Installed skills do not appear

Check the install destination:

```bash
ls ~/.hermes/skills/software-development/frontend-token-trim/SKILL.md
```

If you use a custom skills directory, set it explicitly:

```bash
HERMES_SKILLS_DIR=/path/to/skills/software-development ./install.sh
```

Start a new Hermes session after installing.

## Codex, Claude, or OpenClaude do not pick up the rules

These agents do not load Hermes skills directly. Copy the matching file to your project root:

```bash
cp templates/AGENTS.md /path/to/project/AGENTS.md
cp templates/CLAUDE.md /path/to/project/CLAUDE.md
cp templates/OPENCLAUDE.md /path/to/project/OPENCLAUDE.md
```

## Token savings look small

The pack reduces waste when the task would otherwise trigger broad reading or broad refactors. Savings may be small for tiny one-file edits. Good comparison means lower tokens plus same or better verification.
