#!/bin/bash
function environment_path() {
	case ":$PATH:" in
		*:"$HOME/.local/bin":*) ;;
		*) export PATH="$HOME/.local/bin:$PATH" ;;
	esac
}

environment_path
unset -f environment_path
