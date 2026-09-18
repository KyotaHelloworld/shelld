#!/bin/bash
function golang_env_var() {
	export GOPATH="${GOPATH:-$HOME/go}"

	case ":$PATH:" in
		*:"$GOPATH/bin":*) ;;
		*) export PATH="$GOPATH/bin:$PATH" ;;
	esac

	if command -v goenv >/dev/null 2>&1; then
		export GOENV_ROOT="${GOENV_ROOT:-$HOME/.goenv}"
		eval "$(goenv init -)"
	fi
}

golang_env_var
unset -f golang_env_var
