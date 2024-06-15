#!/bin/bash
function alias_yay(){
	# Install and Remove Packages
	alias install='ysy -S'
	alias uninstall='sudo apt-get --purge autoremove'
	alias search='yay -Ss'
}

alias_yay
unset -f alias_yay