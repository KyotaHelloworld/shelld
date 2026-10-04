#!/bin/bash
function alias_paru() {
	# Remove and search packages with paru.
	alias uninstall='paru -Rns'
	alias search='paru -Ss'
}

alias_paru
unset -f alias_paru
