#!/bin/bash
function golang_env_var() {
	export GOPATH="${GOPATH:-$HOME/go}"

	case ":$PATH:" in
		*:"$GOPATH/bin":*) ;;
		*) export PATH="$GOPATH/bin:$PATH" ;;
	esac

	export GOENV_ROOT="${GOENV_ROOT:-$HOME/.goenv}"
	if [[ -x "$GOENV_ROOT/bin/goenv" ]]; then
		case ":$PATH:" in
			*:"$GOENV_ROOT/bin":*) ;;
			*) export PATH="$GOENV_ROOT/bin:$PATH" ;;
		esac
	fi
	if command -v goenv >/dev/null 2>&1; then
		eval "$(goenv init -)"
	fi
}

golang_env_var
unset -f golang_env_var
