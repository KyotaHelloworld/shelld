function dir1_test(){
	
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))
	echo "from dir1/test this_dir UPDATED:" "${this_dir/#$HOME/\~}"
	load_dirs_init "$this_dir"
}


dir1_test