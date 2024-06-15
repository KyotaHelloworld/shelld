#!/bin/bash
setup_file=$HOME/shelld/init.sh

if [ -r $setup_file ]; then
	source $setup_file
else
	echo "cannot find zsh setting file"
fi
