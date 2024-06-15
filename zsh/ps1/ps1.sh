#!/bin/zsh
function set_ps1(){
	export PS1='[%F{4}%M%f] %F{3}%D{%m/%d} %T%f @%F{2}%~%f
%F{5}%n%f %(#.🦋.🐛) : '
}

set_ps1
unset -f set_ps1
