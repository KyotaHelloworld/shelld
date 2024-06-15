#!/bin/zsh
function alias_ping_init(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))

	load_dir_files "$this_dir"
}

alias_ping_init
unset -f alias_ping_init