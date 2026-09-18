#!/bin/bash
function alias_paru() {
	# Install, remove, and search packages with paru.
	alias install='paru -S'
	alias uninstall='paru -Rns'
	alias search='paru -Ss'
}

alias_paru
unset -f alias_paru
