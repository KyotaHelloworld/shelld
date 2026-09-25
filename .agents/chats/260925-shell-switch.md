# Shell switching conversation

- Request: Fix unreliable shell switching and simplify the repository where evidence supports it.
- Constraints: Bash and Zsh only; paru is the package manager.
- Work: Fixed symmetric Bash/Zsh switching, rc backup and quoting, and confirmed startup simplifications. Audit details are in `docs/audits/20260925-01-shell-switch/`.
- Branch: `codex/fix-shell-switch`; task worktree is external to the repository.
- Validation: Mocked Make and account failures, both shell startup paths, spaced paths, Git prompt states, syntax, and Make completion passed. Host login shell was not changed.
- Commits: `29ae578`, `fe2969c`, `cf3ca37`, and `1a4a0fa`; the final documentation correction follows.
- Final check: a fresh interactive Zsh prompt exposed a missing right status display; a `precmd` hook now renders it and remains single on reload.
- Next: Obtain acceptance before local merge.
