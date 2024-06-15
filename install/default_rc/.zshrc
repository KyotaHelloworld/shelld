#!/bin/zsh
function initial_load(){
	shelld_init=$HOME/shelld/init.sh

	if [ -r $shelld_init ]; then
		source $shelld_init
	else
		echo "cannot find zsh setting file"
	fi
}

initial_load
unset -f initial_load
