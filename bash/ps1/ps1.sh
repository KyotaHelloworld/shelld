#!/bin/bash
function set_ps1() {
	local shell_mark='🐛'
	if [[ $EUID -eq 0 ]]; then
		shell_mark='🦋'
	fi

	PS1='[\[\e[34m\]\h\[\e[0m\]] \[\e[33m\]\D{%m/%d} \t\[\e[0m\] @\[\e[32m\]\w\[\e[0m\]\n\[\e[35m\]\u\[\e[0m\] '"$shell_mark"' : '
}

set_ps1
unset -f set_ps1
