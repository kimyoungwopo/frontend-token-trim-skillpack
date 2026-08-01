# Update Policy

[← README](../README.md) · [Troubleshooting](troubleshooting.md)

## User updates

Users update a git clone with:

```bash
cd frontend-token-trim-skillpack
./update.sh
```

`update.sh` does two things:

1. fast-forwards the repo from `origin/main`
2. reruns `install.sh`

Existing installed skills are backed up under:

```txt
~/.hermes/skill-backups/frontend-token-trim/software-development/
```

Backups are intentionally outside active skill discovery, so Hermes does not see backup copies as duplicate skills.

## Upstream updates

`ponytail` is adapted from `DietrichGebert/ponytail`. The repo tracks the upstream commit in:

```txt
.upstream/ponytail.head
```

The scheduled GitHub Action runs weekly and checks for upstream changes. If upstream changed, it opens a PR.

## Why no silent auto-merge

Skill text is behavior. A small prompt change can change how agents edit files, verify work, or report risk. For that reason, upstream updates are automated as PRs, not silent merges.

PR review should check:

- license and NOTICE remain correct
- behavior changes are acceptable
- frontend QA and security/data-integrity checks were not weakened
- docs still match the shipped behavior

## Project-authored skills

`graphify`, `headroom`, and `frontend-token-trim` are updated directly in this repository. Users receive those updates on the next `./update.sh`.
