# Shell switching task

- Objective: Make Bash and Zsh apply operations select the corresponding login shell, retain recoverable rc contents, and report failures accurately.
- Branch: `codex/fix-shell-switch`
- Acceptance: Both directions work under mocked host commands; startup works in both shells; whole repository audit converges.
- Current state: Implementation and audit validation complete in the task worktree.
- Validation: Mocked switch/install, isolated shell startup, spaced paths, Git prompt states, fresh interactive Zsh PTY, Make completion, syntax, and diff check passed.
- Commits: `29ae578` for switching, `fe2969c` for startup simplification, `cf3ca37` for the audit record, and `1a4a0fa` for the interactive prompt correction. This record update is the final documentation commit.
- Next: Await acceptance before local `master` merge.
