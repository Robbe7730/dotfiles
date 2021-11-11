# Fuzzy find and cd to a directory
function fzf_dir() {
	[ $1 = "" ] && return
	file="$(locate $1 | fzf)"
	[ $file = "" ] && return
	folder="$(dirname $file)"
	cd $folder
}

# add submodule to nvim
function addnvimmodule() {
	if [ "$1" = "" ]; then
		echo "Usage: addnvimmodule <user>/<repo>" >&2
		return 1
	fi

	if (echo "$1" | grep -Eqv "^[a-zA-Z0-9._-]+/[a-zA-Z0-9._-]+$"); then
		echo "Invalid user/repo: $1" >&2
		return 1
	fi

	# Add plugin to init.vim
	sed -i "/\"NEW_PLUG/i \
Plug '$1'" $HOME/.files/nvim_init.vim

	# Add plugin to nvim_modules.md
	echo "$1: " >>$HOME/.files/nvim_plugins.md

	# Install plugin and show files for further configuration
	nvim +PlugInstall $HOME/.files/nvim_init.vim $HOME/.files/nvim_plugins.md
}

# run a Flask app
function runFlask() {
	export FLASK_APP="$1"
	export FLASK_DEBUG=true
	flask run
}

# get the full path of a file/directory
function path() {
	parent=$(pwd)
	echo $parent/$1
}

# transform markdown into pdf
function mdtopdf() {
	second="$2"
	if [ "$second" == "" ]; then
		second=$(echo $1 | sed "s/^\(.*\)\.md$/\1.pdf/")
	fi
	pandoc "$1" --pdf-engine=xelatex -V "geometry:margin=1in" -V "papersize:a4" -o "$second"
}

# transform markdown into html
function mdtohtml() {
	second="$2"
	if [ "$second" == "" ]; then
		second=$(echo $1 | sed "s/^\(.*\).md$/\1.html/")
	fi

	pandoc "$1" -s -o "$second"
}

# add wifi network to wpa_supplicant config
function addWifi() {
	if [ "$2" == "" ]; then
		echo "network={" >>/etc/wpa_supplicant/wpa_supplicant-wlo1.conf
		echo "	ssid=\"$1\"" >>/etc/wpa_supplicant/wpa_supplicant-wlo1.conf
		echo "	key_mgmt=NONE" >>/etc/wpa_supplicant/wpa_supplicant-wlo1.conf
		echo "}" >>/etc/wpa_supplicant/wpa_supplicant-wlo1.conf
	else
		res=$(wpa_passphrase "$1" "$2")
		if [ $? == 0 ]; then
			echo $res >>/etc/wpa_supplicant/wpa_supplicant-wlo1.conf
		else
			echo $res
		fi
	fi
}

# enable ADB over network
function adbNet() {
	if [ "$1" == "" ]; then
		echo "Please enter a valid ip address"
		return 1
	fi
	adb tcpip 5555
	adb connect $1:5555
}

