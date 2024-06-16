#!/bin/zsh
function completion_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
	load_dirs_init "$this_dir"

	# autoload scans each path within the fpath variable for files starting with an underscore
	# and loads the corresponding script as a function file
	autoload -Uz compinit
	# compinit: Initializes the shell’s auto-completion functionality
	compinit
}
completion_init
unset -f completion_init
