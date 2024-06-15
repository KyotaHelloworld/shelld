function dir1_init(){
	
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))
	echo "from dir1/init this_dir UPDATED:" "${this_dir/#$HOME/\~}"
	load_dirs_init "$this_dir"
	load_dir_files "$this_dir"
}

dir1_init