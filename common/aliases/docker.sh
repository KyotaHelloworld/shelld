#!/bin/bash
function alias_docker(){
	alias d='docker'
	alias dc='docker compose'
}

alias_docker
unset -f alias_docker
