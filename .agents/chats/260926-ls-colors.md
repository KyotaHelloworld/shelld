# ls color warning

- Request: Fix the `ls: unparsable value for LS_COLORS environment variable` warning reported from an interactive shell.
- Finding: Sourcing the project color settings reproduces the warning in Bash and Zsh. Isolating each of the 60 color entries found only `Makefile=35;104` invalid.
- Branch: `codex/fix-ls-colors`.
- Fix: Changed the bare `Makefile` key to the accepted `*Makefile` pattern.
- Validation: Both shells sourced the full settings without stderr from `ls --color=always Makefile`; Makefile retained its intended color. Bash/Zsh syntax checks and `git diff --check` passed.
- Decision: kyota instructed that completed work be integrated into `master` and pushed each time.
- Next: Merge this verified fix into `master` and push the configured remote.
