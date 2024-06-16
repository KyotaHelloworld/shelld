#!/bin/zsh
function completion_make_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
	load_dir_files "$this_dir"
}
completion_make_init
unset -f completion_make_init
