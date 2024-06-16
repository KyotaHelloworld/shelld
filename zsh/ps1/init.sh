#!/bin/zsh
function ps1_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))

	load_dir_files "$this_dir"
}

ps1_init
unset -f ps1_init
