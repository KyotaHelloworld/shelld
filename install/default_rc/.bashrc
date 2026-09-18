#!/bin/bash
function initial_load() {
	if [ -r "$this_shelld_path" ]; then
		source "$this_shelld_path"
	else
		echo "cannot find shell setting file: $this_shelld_path" >&2
	fi
}

# will add some lines when copy this file to HOME
