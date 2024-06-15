#!/bin/bash
function bash_init(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))

	load_dir_files "$this_dir"
}
bash_init
unset -f bash_init

