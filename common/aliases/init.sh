#!/bin/zsh
function alias_init() {
	if [ -n "$BASH_VERSION" ]; then
		local this_source="${BASH_SOURCE[0]}"
	else
		local this_source="${(%):-%x}"
	fi
	local this_dir
	this_dir=$(dirname "$this_source")

	if [[ $(uname -s) == Darwin ]]; then
		load_dir_files "$this_dir" paru.sh systemctl.sh
	else
		load_dir_files "$this_dir"
	fi
}

alias_init
unset -f alias_init
