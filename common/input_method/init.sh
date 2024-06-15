#!/bin/bash
function input_method_init(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))

	load_dir_files "$this_dir"
}

input_method_init
unset -f input_method_init
