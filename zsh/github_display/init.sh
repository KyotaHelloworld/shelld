#!/bin/zsh
function github_display_init(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))

	load_dir_files "$this_dir"
}

github_display_init
unset -f github_display_init
