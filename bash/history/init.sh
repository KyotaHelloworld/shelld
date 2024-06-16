#!/bin/bash
function history_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))

	load_dir_files "$this_dir"
}

history_init
unset -f history_init
