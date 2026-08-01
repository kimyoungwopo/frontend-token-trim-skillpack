# Security Policy

Frontend Token Trim Skillpack is a prompt/rule/skill distribution repo. It should not contain secrets.

## Supported versions

The latest `main` branch and latest GitHub release are supported.

## What to report

Please report:

- leaked API keys, tokens, passwords, cookies, or connection strings
- install/update scripts that can overwrite unexpected paths
- prompt/rule changes that encourage unsafe behavior
- instructions that weaken authentication, authorization, data-integrity, or QA checks
- malicious links or supply-chain concerns in workflows/scripts

## What not to report here

General model mistakes, non-security prompt preference changes, or frontend style disagreements are regular issues or PRs.

## How to report

Open a GitHub issue if the report does not contain secrets.

If the report contains credentials or sensitive material, do not paste them into an issue. Contact the maintainer privately through GitHub profile contact channels, or open a minimal issue saying a private security report is needed.

## Security principles

- No credentials in docs, examples, transcripts, or benchmark artifacts.
- Keep backups outside active skill discovery.
- Upstream prompt changes create PRs and are reviewed before merge.
- Token saving must not skip source inspection, auth checks, data-integrity checks, or frontend QA.
