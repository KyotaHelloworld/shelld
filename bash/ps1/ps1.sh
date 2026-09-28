#!/bin/bash
function set_ps1() {
	local host_icon='' user_icon=' 🐛'
	case ${HOSTNAME%%.*} in
		baikin-castle) host_icon=' 🏰' ;;
		baikin-ufo)    host_icon=' 🛸' ;;
		dadandan)      host_icon=' 🤖' ;;
		bakery)        host_icon=' 🥐' ;;
	esac
	case $USER in
		root)        user_icon=' 👑' ;;
		baikimman)   user_icon=' 👾' ;;
		dokinchan)   user_icon=' 😈' ;;
		kabilunlun)  user_icon=' 🦠' ;;
	esac

	PS1='[\[\e[34m\]\h\[\e[0m\]'"$host_icon"'] \[\e[33m\]\D{%m/%d} \A\[\e[0m\] \[\e[32m\]\w\[\e[0m\]\n\[\e[35m\]\u\[\e[0m\]'"$user_icon"' ❯ '
}

set_ps1
unset -f set_ps1
