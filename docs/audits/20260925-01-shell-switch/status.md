# Shell switching audit status

- Updated: 2026-09-25
- Baseline: `868694c`
- Phase: Final
- Overall: Complete
- Branch: `codex/fix-shell-switch`

## Coverage summary

All six requirements rows passed. Bash 5.3.20, Zsh 5.9.2, and paru 2.1.0 were available. Validation used isolated HOME directories and mocked account commands; the host login shell was not changed.

## Findings

| ID | Severity | Confidence | Summary | Evidence | State |
| --- | --- | --- | --- | --- | --- |
| AUD-20260925-01-F001 | P1 | Confirmed | `apply-bash` never changes the login shell | `Makefile` Bash target only invokes rc installer | RESOLVED |
| AUD-20260925-01-F002 | P1 | Confirmed | Zsh switch reports success even if `chsh` fails | Former `install/change_to_zsh.sh` lacked status and postcondition checks | RESOLVED |
| AUD-20260925-01-F003 | P2 | Confirmed | Missing Zsh uses pacman or apt despite paru-only package management | Former installation branches | RESOLVED |
| AUD-20260925-01-F004 | P2 | Confirmed | rc backup path is in the repository and timestamp can collide | Former `install/install.sh` backup helpers | RESOLVED |
| AUD-20260925-01-F005 | P2 | Confirmed | Shell startup sources the standalone goenv installer | `common/golang/init.sh` formerly loaded every `*.sh` | RESOLVED |
| AUD-20260925-01-F006 | P2 | Confirmed | Installed goenv is not found in a fresh HOME | `golang.sh` formerly checked PATH before adding goenv | RESOLVED |
| AUD-20260925-01-F007 | P3 | Confirmed | `dircolors` output is immediately overwritten by the project's palette | `common/aliases/ls.sh` precedes `common/ls_color/color.sh` | RESOLVED |
| AUD-20260925-01-F008 | P2 | Confirmed | Git prompt parses localized human output and runs redundant text processes | Former `zsh/github_display/display.sh` parsed `git status` text | RESOLVED |
| AUD-20260925-01-F009 | P3 | Confirmed | Git completion module does nothing | Former `zsh/completion/git/init.sh` only invoked `true` | RESOLVED |
| AUD-20260925-01-F010 | P2 | Confirmed | Generated rc fails when checkout path contains spaces | Former `install/install.sh` emitted an unquoted assignment | RESOLVED |
| AUD-20260925-01-F011 | P2 | Confirmed | History file creation splits HOME paths with spaces | Both shell history scripts ran unquoted `touch $HISTFILE`; reproduced in temporary HOME | RESOLVED |
| AUD-20260925-01-F012 | P2 | Confirmed | Git right prompt stays empty after startup | Interactive Zsh showed `prompt_subst` disabled after loader returned | RESOLVED |

## Remediation and validation

- F001–F004, F010: both Make apply targets now select the shell through one checked script, then install a generated rc with a unique HOME backup. Mocked Bash/Zsh switching, missing Zsh via paru, unchanged shell, `chsh` failure, unchanged account state, and package failure all returned expected statuses. Full Make runs confirmed rc is unchanged when switching fails. Temporary HOME runs confirmed backup, repeated no-op application, and paths with spaces.
- F005–F007, F011: excluded the manual goenv installer from startup, added installed goenv to PATH, removed overwritten `dircolors` setup, and quoted history paths. Isolated Bash/Zsh source runs confirmed goenv initialization and history files with spaced HOME paths.
- F008–F009: prompt status now uses Git porcelain output; clean, staged, unstaged, and untracked states passed in an isolated Git repository. Unused completion module and stale generated-file ignores were removed. Zsh Make completion still lists all public targets.
- Complete static pass: inspected tracked shell scripts, aliases, loaders, completion, installer, Makefile, README, and demo fixtures. Final Bash/Zsh syntax checks, `make help`, completion words, and `git diff HEAD --check` passed.
- F012: final interactive terminal check exposed a scoped-option regression. A `precmd` hook now sets `RPROMPT`. A fresh Zsh PTY with `TERM=xterm-256color` displayed the branch/status marker; sourcing settings again kept exactly one hook.

## Bounded exclusions

- The standalone goenv installer and demo fixtures were not exercised against network services; they are outside the shell-switching runtime path. No network or live account change was made.
- Wrapper repetition and demo fixture cleanup were left in place because no practical benefit justified touching more files.

## Repository state and next action

The switch fix is committed as `29ae578`; startup simplification as `fe2969c`; interactive prompt correction as `1a4a0fa`. After acceptance, merge the task branch into local `master` with a merge commit. No push is planned.
