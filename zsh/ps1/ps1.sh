#!/bin/zsh
function set_ps1() {
	local host_icon='' user_icon=' 🐛'
	case ${HOST%%.*} in
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

	export PS1='[%F{4}%m%f'"$host_icon"'] %F{3}%D{%m/%d} %D{%H:%M}%f %F{2}%~%f
%F{5}%n%f'"$user_icon"' ❯ '
}

set_ps1
unset -f set_ps1
