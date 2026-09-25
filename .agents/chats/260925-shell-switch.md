# Shell switching conversation

- Request: Fix unreliable shell switching and simplify the repository where evidence supports it.
- Constraints: Bash and Zsh only; paru is the package manager.
- Work: Fixed symmetric Bash/Zsh switching, rc backup and quoting, and confirmed startup simplifications. Audit details are in `docs/audits/20260925-01-shell-switch/`.
- Branch: `codex/fix-shell-switch`; task worktree is external to the repository.
- Validation: Mocked Make and account failures, both shell startup paths, spaced paths, Git prompt states, syntax, and Make completion passed. Host login shell was not changed.
- Commits: `29ae578` and `fe2969c`; audit record follows in the final documentation commit.
- Next: Obtain acceptance before local merge.
