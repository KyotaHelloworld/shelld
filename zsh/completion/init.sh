#!/bin/zsh
function completion_init() {
	if [ -n "$BASH_VERSION" ]; then
		local this_source="${BASH_SOURCE[0]}"
	else
		local this_source="${(%):-%x}"
	fi
	local this_dir
	this_dir=$(dirname "$this_source")
	autoload -Uz compinit
	compinit

	# Individual completion scripts can safely call compdef after compinit.
	load_dirs_init "$this_dir"
}
completion_init
unset -f completion_init
