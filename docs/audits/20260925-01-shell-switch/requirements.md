# Shell switching and simplification audit

- Status: Complete
- Baseline: local `master` at `868694c`; clean primary worktree
- Task branch: `codex/fix-shell-switch`
- Scope: all tracked shell scripts, Makefile, README, and focused runtime behavior
- Supported shells: Bash and Zsh
- Package manager for installing missing shells: paru
- Audit schema: `audit-project-thoroughly` skill, 2026-09-25

## Goals

- Applying either shell selects it as the login shell and installs the matching rc file.
- Failures stop the operation with a nonzero status and an actionable message.
- Existing rc contents remain recoverable.
- Remove evidenced duplication and obsolete package manager paths without changing unrelated aliases or feature behavior.

## Exclusions

- No actual login-shell or home rc change on the user's host during validation.
- No other shells, package managers, remote systems, or UI.

## Coverage matrix

| ID | Lane and scenario | Method | State |
| --- | --- | --- | --- |
| AUD-20260925-01-C001 | Make targets and switch lifecycle for Bash and Zsh | Static trace and mocked command runs | PASS |
| AUD-20260925-01-C002 | rc install, backup, path quoting, repeat application, failure | Temporary HOME integration runs | PASS |
| AUD-20260925-01-C003 | Bash and Zsh init loading, aliases, completion, path handling | Static scan and isolated shell source | PASS |
| AUD-20260925-01-C004 | Duplicated, unreachable, or obsolete code across tracked files | Complete source review and diff check | PASS |
| AUD-20260925-01-C005 | README accuracy and validation entry points | Command verification and link check | PASS |
| AUD-20260925-01-C006 | Final clean pass for all preceding lanes | Reinspect final diff and rerun focused gates | PASS |

## Host and runtime gates

- Syntax checks for changed shell scripts.
- Mocked Bash/Zsh switch success, already selected, missing shell, package install failure, chsh failure, and verification failure.
- Temporary HOME rc backup and startup checks for both shells.
- `git diff --check` and final source pass.

## Acceptance criteria

- `make apply-bash` and `make apply-zsh` route through the same verified Bash/Zsh switch process.
- Missing Zsh is installed with paru only; missing Bash produces a clear error or is installed with paru if available.
- A failed install or `chsh` cannot report success or overwrite the selected rc.
- Backup files are unique and outside the tracked repository; paths with spaces work.
- Both generated rc files load shelld when sourced by the matching shell.
- Every coverage row reaches PASS or has an explicit blocker in the report.
