#!/bin/zsh
function zsh_init() {
	if [ -n "$BASH_VERSION" ]; then
		local this_source="${BASH_SOURCE[0]}"
	else
		local this_source="${(%):-%x}"
	fi
	local this_dir
	this_dir=$(dirname "$this_source")
	load_dirs_init "$this_dir"
}
zsh_init
unset -f zsh_init
