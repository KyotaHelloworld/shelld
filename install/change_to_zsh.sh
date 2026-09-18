#!/bin/bash

function install_zsh_pacman() {
	echo 'installing zsh using pacman...'
	sudo pacman -S --needed zsh
}
function install_zsh_apt() {
	echo 'installing zsh ...'
	sudo apt-get update
	sudo apt-get install -y zsh
}

function change_to_zsh() {
	zshpath=$(command -v zsh)
	if [[ -z $zshpath ]]; then
		if command -v pacman >/dev/null 2>&1; then
			install_zsh_pacman
		elif command -v apt-get >/dev/null 2>&1; then
			install_zsh_apt
		else
			echo "install zsh manualy"
			return 1
		fi
	else
		echo 'installing zsh skiped.'
	fi
	zsh --version
	zshpath=$(command -v zsh)

	current_shell=$(getent passwd "$USER" | cut -d: -f7)
	if [[ "$current_shell" == "$zshpath" ]]; then
		echo "default shell is already zsh: $zshpath"
	else
		chsh -s "$zshpath"
		echo "default shell changed to zsh: $zshpath"
	fi

	# Refresh the user service / D-Bus activation environment so newly launched
	# desktop applications can see the new shell without waiting for next login.
	if command -v systemctl >/dev/null 2>&1; then
		systemctl --user set-environment "SHELL=$zshpath" 2>/dev/null || true
	fi
	if command -v dbus-update-activation-environment >/dev/null 2>&1; then
		dbus-update-activation-environment --systemd "SHELL=$zshpath" 2>/dev/null || true
	fi

	echo "shell environment updated: SHELL=$zshpath"
	echo "if an already-running terminal application still opens bash, log out and back in once"
}

change_to_zsh
