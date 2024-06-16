#!/bin/zsh
function alias_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))

	load_dir_files "$this_dir"
}

alias_init
unset -f alias_init
