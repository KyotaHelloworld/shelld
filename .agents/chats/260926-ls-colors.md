# ls color warning

- Request: Fix the `ls: unparsable value for LS_COLORS environment variable` warning reported from an interactive shell.
- Finding: Sourcing the project color settings reproduces the warning in Bash and Zsh. Isolating each of the 60 color entries found only `Makefile=35;104` invalid.
- Branch: `codex/fix-ls-colors`.
- Fix: Changed the bare `Makefile` key to the accepted `*Makefile` pattern.
- Validation: Both shells sourced the full settings without stderr from `ls --color=always Makefile`; Makefile retained its intended color. Bash/Zsh syntax checks and `git diff --check` passed.
- Next: Commit the verified change; local integration follows user acceptance.
