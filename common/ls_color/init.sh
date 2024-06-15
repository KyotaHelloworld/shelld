#!/bin/bash
function ls_color_init(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))

	load_dir_files "$this_dir"
}

ls_color_init
unset -f ls_color_init
