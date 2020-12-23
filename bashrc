#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

# easily go to the current semester folder
export huidigSemester="$HOME/Documents/UGent/Master/2020-2021/semester1/"

# set PATHs
export PATH=$HOME/Documents/ASM/gcc-cross/opt2/cross/bin/:$HOME/Documents/ASM/gcc-cross/opt/cross/bin/:$HOME/.local/bin:$HOME/.gem/ruby/2.5.0/bin:$HOME/.rbenv/bin:/home/robbe/.cargo/bin:$PATH:$HOME/.files/i3/scripts
export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"

# visual
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# random but cool
alias cammiechat="curl 'https://kelder.zeus.ugent.be/messages/' -H 'X-Username: Robbe' -H 'Content-Type: text/plain' --compressed --data-binary "
alias rienhorn="bash <(curl -s https://i.rxn.be/keyhorn.png)"
alias cammie='mpv --no-correct-pts --fps=5 http://kelder.zeus.ugent.be/webcam/video/mjpg.cgi'
alias suod="sl"
alias shrug="echo \"¯\_(ツ)_/¯\""
alias pparrot="terminal-parrot --delay 49"
alias probleem="echo Vertel...; while [ 1 -eq 1 ]; do read; echo Zoek het zelf uit; done"
alias yay="mpv --fs $HOME/Videos/yay.mkv"
alias :q="vim <(echo 'TIS GEEN VIM')"

# java-related
alias junit="java org.junit.runner.JUnitCore"
alias jc="javac *.java; java"
alias ju="javac *.java; junit"

# wifi-related
alias fixwifi="sudo systemctl restart wpa_supplicant@wlo1"
alias wifistatus="watch systemctl status wpa_supplicant@wlo1"
alias vimwpa="vim /etc/wpa_supplicant/wpa_supplicant-wlo1.conf"

# shortening of common commands
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias vimrc="vim $HOME/.bashrc"
alias fix="pacaur -Sy"
alias gtfo="pacaur -Rss"
alias printmd="pandoc -f markdown -t plain"
alias copy="xclip -selection clipboard"
alias copygpg="gpg --armor --export robbevanherck1@gmail.com | copy"
alias copyssh="cat $HOME/.ssh/id_rsa.pub | copy"
alias cdhs="cd $huidigSemester"
alias capsstate="xset -q | grep \"Caps Lock\" | sed \"s/^.*Caps Lock: *\([onf]*\) .*$/\1/\""
alias untar="tar -xvf"
alias keldermuziek="ncmpcpp -h 10.0.0.5"
alias pptToPdf="unoconv -f pdf"
alias kelderforward="pax11publish -e -S 10.0.0.5"
alias kelderbackward="pax11publish -e -S \"\""
alias readme="pandoc -f gfm -t plain -s README.md | less"
alias stubru="mpv https://live-radio.lwc.vrtcdn.be/groupc/live/f404f0f3-3917-40fd-80b6-a152761072fe/live.isml/.m3u8"
alias gpp="g++"
alias fixchrome="sudo chmod 1777 /dev/shm"
alias gpg_master="gpg --home=/mnt/gpg/.gnupg"
alias tijdloze="mpv https://live-radio.lwc.vrtcdn.be/groupc/live/582109ca-1e71-4330-93fc-e9affee94d7d/live.isml/.m3u8"
alias youtube-mp3="youtube-dl --extract-audio --audio-format mp3"
alias updatenvimmodules="nvim +PlugClean +PlugUpdate +qa"
alias pong="ping robbevanherck.be"
alias willy="mpv https://playerservices.streamtheworld.com/api/livestream-redirect/WILLY.mp3"

# Bluetooth
alias bluetoothon="echo power on | bluetoothctl"
alias bluetoothoff="echo power off | bluetoothctl"
alias connectheadphones="echo connect D0:8A:55:33:74:F6 | bluetoothctl"

# Haskell
alias runghc="stack runghc"

# JUnit-setup
JUNIT_HOME="$HOME/Documents/Java/JUnit/junit4.10"
export CLASSPATH=$CLASSPATH:$JUNIT_HOME/junit.jar:$HOME/Documents/Java/gson.jar

# Prompt String
PS1='[\u@\h \W]\$ '

# Check if the system needs to be updated (current: 5 days)
update -b 432000

# Add autocomplete to pandoc
. <(pandoc --bash-completion)

# Tell git about my gpg key
export GPG_TTY=$(tty)

# Why use nano?
export EDITOR="nvim"

# Why use vim?
alias vim="nvim"

eval "$(rbenv init -)"

HISTCONTROL=ignoreboth

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"
export PATH
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL5LIB
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_LOCAL_LIB_ROOT
PERL_MB_OPT="--install_base \"$HOME/perl5\""
export PERL_MB_OPT
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
export PERL_MM_OPT
export LD_LIBRARY_PATH=/usr/local/bin/openssl

# Automatically use more jobs
export MAKEFLAGS="-j4"

# Fix npm/NodeJS
export NODE_PATH=/usr/lib/node_modules/

# Passwordwinkel peeters
alias zpass='PASSWORD_STORE_DIR=~/.zeus-wachtwoord-winkel pass'
alias zpassmenu='PASSWORD_STORE_DIR=~/.zeus-wachtwoord-winkel passmenu'

# Remind me of all the things that exist
ding

# Remind me to BETAAL MIJN FUCKING SCHULDEN
# tabBalance -s 1.6

# For GBA dev
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export DEVKITPPC=/opt/devkitpro/devkitPPC

export PATH=$DEVKITPRO/tools/bin:$PATH

# For CUDA
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64"
export CUDA_HOME=/opt/cuda/

# Redpencil mu-cli
PATH="/home/robbe/Documents/redpencil.io/mu-cli/:$PATH"
source /home/robbe/Documents/redpencil.io/mu-cli/completions

# Rustup
PATH="$HOME/.cargo/bin:$PATH"
