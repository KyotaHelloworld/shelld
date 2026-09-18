function dir1_test() {

	if [ -n "$BASH_VERSION" ]; then
		local this_source="${BASH_SOURCE[0]}"
	else
		local this_source="${(%):-%x}"
	fi
	local this_dir
	this_dir=$(dirname "$this_source")
	echo "from dir1/test this_dir UPDATED:" "${this_dir/#$HOME/\~}"
	load_dirs_init "$this_dir"
}

dir1_test
