#!/bin/bash
function alias_cd(){
	alias cd.='cd ..'
	alias ..='cd ..'
	alias ...='cd ../../'
	alias ....='cd ../../../'
	alias .....='cd ../../../'
	alias .2='cd ../../'
	alias .3='cd ../../../'
	alias .4='cd ../../../../'
	alias .5='cd ../../../../..'
	alias cd..='cd ..'

	alias ..l='cd .. && ls -aCF'
	alias ...l='cd ../../ && ls -aCF'
	alias ....l='cd ../../../ && ls -aCF'
	alias .....l='cd ../../../ && ls -aCF'

	alias CD='cd'
}

alias_cd
unset -f alias_cd

