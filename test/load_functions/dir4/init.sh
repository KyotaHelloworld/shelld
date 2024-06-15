function dir4_init(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))

	echo "From dir4/init"
	load_dir_files "$this_dir" "test3.sh"
}

dir4_init