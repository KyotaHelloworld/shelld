function install_zsh_yay(){
	echo 'installing zsh ...'
	sudo yay
	sudo yay -S zsh
}
function install_zsh_apt(){
	echo 'installing zsh ...'
	sudo apt-get update -y && sudo apt-get upgrade -y
	sudo apt-get install -y zsh
}

function change_to_zsh(){
	zshpath=$(which zsh)
	if [[ -z $zshpath ]]; then
		if [[ -n `which yay` ]]; then
			install_zsh_yay
		elif  [[ -n `which apt` ]]; then
			install_zsh_apt
		else
			echo "install zsh manualy"
			return -1
		fi
	else
		echo 'installing zsh skiped.'
	fi
	zsh --version 
	zshpath=$(which zsh)
	chsh -s $(which zsh)
	echo "when you reboot, default shell is changed to zsh"
}

change_to_zsh