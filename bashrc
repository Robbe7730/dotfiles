#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# add submodule to nvim
function addnvimmodule() {
        pushd /home/robbe/.config/nvim/bundle
        git submodule add $1
        vim status.md
        popd
}

# run a Flask app
function runFlask() {
	export FLASK_APP="$1"
	flask run
}

# get the full path of a file/directory
function path() {
	parent=`pwd`
	echo $parent/$1
}

# transform markdown into pdf
function mdtopdf() {
	second="$2"
	if [ "$second" == "" ]
	then
		second=`echo $1 | sed "s/^\(.*\)\.md$/\1.pdf/"`
	fi
	pandoc "$1" --pdf-engine=xelatex -V "geometry:margin=1in" -V "papersize:a4" -o "$second"
}

# transform markdown into html
function mdtohtml() {
	second="$2"
	if [ "$second" == "" ]
	then
		second=`echo $1 | sed "s/^\(.*\).md$/\1.html/"`
	fi

	pandoc "$1" -s -o "$second" 
}

# add wifi network to wpa_supplicant config
function addWifi() {
	if [ "$2" == "" ]
	then
		echo "network={" >> /etc/wpa_supplicant/wpa_supplicant-wlp3s0.conf
		echo "	ssid=\"$1\"" >> /etc/wpa_supplicant/wpa_supplicant-wlp3s0.conf
		echo "	key_mgmt=NONE" >> /etc/wpa_supplicant/wpa_supplicant-wlp3s0.conf
		echo "}" >> /etc/wpa_supplicant/wpa_supplicant-wlp3s0.conf
	else
		res=`wpa_passphrase "$1" "$2"`
		if [ $? == 0 ]
		then
			echo $res >> /etc/wpa_supplicant/wpa_supplicant-wlp3s0.conf
		else
			echo $res
		fi
	fi
}

# enable ADB over network
function adbNet() {
	if [ "$1" == "" ]
	then
		echo "Please enter a valid ip address"
		return 1
	fi
	adb tcpip 5555
	adb connect $1:5555
}

# easily go to the current semester folder
export huidigSemester="$HOME/Documents/2018-2019/semester1/"

# set PATHs
export PATH=$HOME/.local/bin:$HOME/.gem/ruby/2.5.0/bin:$HOME/.rbenv/bin:/usr/bin/python2:$PATH:$HOME/.files/i3/scripts
export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"

# visual
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# random but cool
alias rainbows='yes ███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| lolcat'
alias cammiechat="curl 'https://kelder.zeus.ugent.be/messages/' -H 'X-Username: Robbe' -H 'Content-Type: text/plain' --compressed --data-binary "
alias ree="img2txt $HOME/Pictures/reeeeeee.gif -W 64 -d none"
alias rienhorn="bash <(curl -s https://i.rxn.be/keyhorn.png)"
alias cammie='curl http://kelder.zeus.ugent.be/webcam/video/mjpg.cgi | mpv --no-correct-pts --fps 5 -'
# alias npm="yarn"
alias suod="sl"
alias vind="find"
alias shrug="echo \"¯\_(ツ)_/¯\""
alias pparrot="terminal-parrot --delay 50"
alias probleem="echo Vertel...; while [ 1 -eq 1 ]; do read; echo Zoek het zelf uit; done"
alias yay="mpv --fs $HOME/Videos/yay.mkv"

# java-related
alias junit="java org.junit.runner.JUnitCore"
alias jc="javac *.java; java"
alias ju="javac *.java; junit"

# wifi-related
alias fixwifi="sudo systemctl restart wpa_supplicant@wlp3s0"
alias wifistatus="watch systemctl status wpa_supplicant@wlp3s0"
alias vimwpa="vim /etc/wpa_supplicant/wpa_supplicant-wlp3s0.conf"

# run python2 instead of python3
alias python="python2"

# shortening of common commands
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias helios="ssh rovherck@helios.ugent.be"
alias webssh="ssh rovherck@webssh.ugent.be"
alias connectUgent="sudo vpnc ugent.conf"
alias disconnectUgent="sudo vpnc-disconnect"
alias vimrc="vim $HOME/.bashrc"
alias fix="pacaur -Sy"
alias gtfo="pacaur -Rss"
alias pong="ping ugent.be"
alias printmd="pandoc -f markdown -t plain"
alias gc="git commit -S -m "
alias copy="xclip -selection clipboard"
alias findfile="sudo find / | dmenu"
alias copygpg="gpg --armor --export robbevanherck1@gmail.com | copy"
alias copyssh="cat $HOME/.ssh/id_rsa.pub | copy"
alias cdhs="cd $huidigSemester"
alias capsstate="xset -q | grep \"Caps Lock\" | sed \"s/^.*Caps Lock: *\([onf]*\) .*$/\1/\""
alias untar="tar -xvf"
alias keldermuziek="ncmpcpp -h 10.0.0.5"
alias free="free --giga -h"
alias pptToPdf="unoconv -f pdf"
alias kelderforward="pax11publish -e -S 10.0.0.5"
alias kelderbackward="pax11publish -e -S \"\""
alias cdaoc="cd /home/robbe/Documents/Haskell/AdventOfCode2018/AdventOfCode/src/"
alias readme="pandoc -f gfm -t plain -s README.md | less"
alias stubru="mpv https://live-radio.lwc.vrtcdn.be/groupc/live/f404f0f3-3917-40fd-80b6-a152761072fe/live.isml/.m3u8"
alias gpp="g++"
alias windhoos="rclone sync /mnt/windows/ Stack:Windhoos -L -v"

# Bluetooth
alias bluetoothon="echo power on | bluetoothctl"
alias bluetoothoff="echo power off | bluetoothctl"
alias connectheadphones="echo connect D0:8A:55:33:74:F6 | bluetoothctl"

# Haskell
alias runghc="stack runghc"

# JUnit-setup
JUNIT_HOME="$HOME/Documents/Java/JUnit/junit4.10/"
export CLASSPATH=$CLASSPATH:$JUNIT_HOME/junit.jar

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

eval $(thefuck --alias)
eval "$(rbenv init -)"

HISTCONTROL=ignoreboth

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
export LD_LIBRARY_PATH=/usr/local/bin/openssl

# For project Sysprog
export LSAN_OPTIONS="suppressions=lsan.supp print_suppressions=0"

# For Trackmania
export WINEDLLOVERRIDES="OpenAl32=n"

# Automatically use more jobs
export MAKEFLAGS="-j4"

# Fix npm/NodeJS
export NODE_PATH=/usr/lib/node_modules/
