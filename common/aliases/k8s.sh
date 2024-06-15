#!/bin/bash
function alias_kube(){
	alias k='kubectl'
	alias kgp='kubectl get pod'
	alias kgs='kubectl get service'
	alias kgd='kubectl get deployment'
	alias kdp='kubectl describe pod'
	alias kds='kubectl describe pod'
	alias kds='kubectl describe pod'
}

alias_kube
unset -f alias_kube