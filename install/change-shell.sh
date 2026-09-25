#!/usr/bin/env bash
set -Eeuo pipefail

help() {
	cat <<'EOF'
Usage: bash install/change-shell.sh <bash|zsh>

Select the login shell for the current user. If the shell is missing, install it
with paru. A new login session is needed to see the change everywhere.
EOF
}

die() {
	printf 'Error: %s\n' "$1" >&2
	return 1
}

installed_shell() {
	local target=$1
	local shell_path

	shell_path=$(command -v "$target" || true)
	if [[ -z $shell_path ]]; then
		command -v paru >/dev/null 2>&1 || {
			die "Neither $target nor paru is available. Install $target first."
			return 1
		}
		paru -S --needed "$target" || {
			die "paru could not install $target."
			return 1
		}
		shell_path=$(command -v "$target" || true)
	fi

	[[ -n $shell_path && -x $shell_path ]] || {
		die "$target is not available after installation."
		return 1
	}
	printf '%s\n' "$shell_path"
}

login_shell() {
	local account
	account=$(getent passwd "$(id -un)") || {
		die 'Could not read the current login shell.'
		return 1
	}
	[[ -n $account && $account == *:* ]] || {
		die 'Could not read the current login shell.'
		return 1
	}
	printf '%s\n' "${account##*:}"
}

change_shell() {
	local target=$1
	local shell_path current_shell
	shell_path=$(installed_shell "$target") || return 1
	current_shell=$(login_shell) || return 1

	if [[ $current_shell -ef $shell_path ]]; then
		printf 'Login shell is already %s (%s).\n' "$target" "$current_shell"
		return 0
	fi

	chsh -s "$shell_path" || {
		die "chsh could not select $shell_path. Check that it is listed in /etc/shells."
		return 1
	}
	current_shell=$(login_shell) || return 1
	[[ $current_shell -ef $shell_path ]] || {
		die "chsh returned successfully, but the login shell is still $current_shell."
		return 1
	}
	printf 'Login shell changed to %s (%s). Log out and back in to use it everywhere.\n' "$target" "$current_shell"
}

main() {
	if [[ ${1:-} == --help || ${1:-} == -h ]]; then
		help
		return 0
	fi
	if [[ $# -ne 1 || ( $1 != bash && $1 != zsh ) ]]; then
		help >&2
		return 2
	fi
	change_shell "$1"
}

main "$@"
