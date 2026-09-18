#!/bin/bash
function ls_color_init() {
	if [ -n "$BASH_VERSION" ]; then
		local this_source="${BASH_SOURCE[0]}"
	else
		local this_source="${(%):-%x}"
	fi
	local this_dir
	this_dir=$(dirname "$this_source")

	load_dir_files "$this_dir"
}

ls_color_init
unset -f ls_color_init
