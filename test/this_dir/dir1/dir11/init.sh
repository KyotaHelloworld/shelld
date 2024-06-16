function dir11_init() {
	echo "from dir11/init" "${this_dir/#$HOME/\~}"
	echo "    ↑ this_dir is not defined in this file. but got an dir name. maybe prev value?"
}

dir11_init
