function dir1_init(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))

	echo "From dir1/init"
	source $this_dir/dir11/init.sh
}

dir1_init