function dir11_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
	echo "From dir11/init"
}

dir11_init
