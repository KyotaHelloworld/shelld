#!/bin/bash
function environment_path() {
	export PATH=$HOME/.local/bin:$PATH
}

environment_path
unset -f environment_path
