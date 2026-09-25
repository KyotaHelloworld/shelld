# Shell switching audit report

- Status: Complete for the declared host and static scope
- Baseline: `868694c`
- Candidate code commits: `29ae578` and `fe2969c`, 2026-09-25

## Verdict

Both apply commands now choose the requested Bash or Zsh login shell, verify the account state, and install the matching rc. Missing shells use paru. A failed switch stops before changing the rc. Existing rc files receive unique backups in HOME, and repeated application is a no-op.

The full source pass resolved 11 confirmed findings: two P1, seven P2, and two P3. The startup cleanup excludes the manual goenv installer, finds an installed goenv, avoids overwritten `dircolors` work, and removes obsolete completion and package-manager paths.

## Evidence

- Mocked `make apply-bash` and `make apply-zsh` passed, including failed `chsh`, unchanged account state, and no rc overwrite on failure.
- Missing Zsh installation through mocked paru passed; mocked paru failure stopped the switch.
- Both generated rc files loaded in isolated Bash and Zsh sessions. Existing rc backup, repeat application, spaced HOME and repository paths passed.
- The Zsh Git prompt passed clean, staged, unstaged, and untracked status cases. Make completion listed every public target.
- All actual Bash/Zsh source files passed syntax checks, and `git diff HEAD --check` passed.

## Boundary and continuation

No real `chsh`, paru install, user rc replacement, network request, or push was performed. The user's login shell and HOME remain unchanged. Run the selected `make apply-bash` or `make apply-zsh` after integration, then log out and back in for existing desktop sessions.

Standalone goenv installation and demo fixtures were outside the runtime validation matrix. The audit found no further cost-effective simplification within the agreed Bash/Zsh and paru scope.
