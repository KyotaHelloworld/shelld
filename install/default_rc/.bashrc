#!/bin/bash
function initial_load(){
	if [ -r $this_shelld_path ]; then
		source $this_shelld_path
	else
		echo "cannot find zsh setting file"
	fi
}

# will add some lines when copy this file to HOME
