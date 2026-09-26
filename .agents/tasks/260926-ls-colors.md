# Fix LS_COLORS parsing

- Objective: Keep the configured file colors while making `ls` run without an `LS_COLORS` parse warning in Bash and Zsh.
- Scope: The shared color entry used by both shell startup paths; check the matching alias and direct `ls` path.
- Baseline: `master` at `1feb180`; primary checkout clean.
- Evidence: All entries were tested individually with GNU ls; `Makefile=35;104` was the sole rejected entry.
- Acceptance: Both shells source the settings; `ls --color=always` emits no warning; Makefile is still colored.
- Branch: `codex/fix-ls-colors`.
- Work: Changed the bare `Makefile` key to `*Makefile` in the shared color configuration.
- Validation: Full Bash/Zsh initialization and colored `ls` produced no stderr; the output contains the configured `35;104` sequence. Both syntax checks and diff check passed.
- Planned commit: `fix: use a valid LS_COLORS pattern for Makefile`.
- Commit: `946c845` contains the verified fix.
- Decision: On 2026-09-26 kyota instructed that completed work be integrated into `master` and pushed each time. This authorizes integration of this fix; the configured remote is `origin`.
- Next: Merge with `--no-ff`, push `master`, and verify the remote tip.
