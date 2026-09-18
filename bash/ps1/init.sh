#!/bin/bash
function ps1_init() {
	local this_dir
	this_dir=$(dirname "${BASH_SOURCE[0]}")

	load_dir_files "$this_dir"
}

ps1_init
unset -f ps1_init
