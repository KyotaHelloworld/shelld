#!/bin/zsh
function initial_load(){
	local root_dir=$(cd $(dirname $0); pwd)
	local this_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
	echo "root_dir" $root_dir
	echo "this_dir" $this_dir

	shelld_init=$this_dir/shelld/init.sh

	if [ -r $shelld_init ]; then
		source $shelld_init
	else
		echo "cannot find zsh setting file"
	fi
}

initial_load
unset -f initial_load
