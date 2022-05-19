# visual
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Cammie-related
alias cammiechat="curl 'https://kelder.zeus.ugent.be/messages/' -H 'X-Username: Robbe' -H 'Content-Type: text/plain' --compressed --data-binary "
alias cammie='mpv --no-correct-pts --fps=5 http://kelder.zeus.ugent.be/webcam/video/mjpg.cgi'

# TUUUUT
alias rienhorn="bash <(curl -s https://i.rxn.be/keyhorn.png)"

# Annoy myself
alias suod="sl"
alias :q="vim <(echo 'TIS GEEN VIM')"

# Shortcuts
alias shrug="echo \"¯\_(ツ)_/¯\""

# random but cool
alias probleem="echo Vertel...; while [ 1 -eq 1 ]; do read; echo Zoek het zelf uit; done"

# java-related
alias junit="java org.junit.runner.JUnitCore"
alias jc="javac *.java; java"
alias ju="javac *.java; junit"

# wifi-related
alias fixwifi="sudo systemctl restart wpa_supplicant@wlo1"
alias wifistatus="watch systemctl status wpa_supplicant@wlo1"
alias vimwpa="vim /etc/wpa_supplicant/wpa_supplicant-wlo1.conf"

# shortening of common commands
alias vimrc="vim $HOME/.bashrc"
alias fix="pacaur -Sy"
alias gtfo="pacaur -Rss"
alias copy="xclip -selection clipboard"
alias copygpg="gpg --armor --export robbevanherck1@gmail.com | copy"
alias copyssh="cat $HOME/.ssh/id_rsa.pub | copy"
alias cdhs="cd $huidigSemester"
alias untar="tar -xvf"
alias readme="pandoc -f gfm -t plain -s README.md | less"
alias youtube-mp3="youtube-dl --extract-audio --audio-format mp3"
alias updatenvimmodules="nvim +PlugClean +PlugUpdate +qa"
alias pong="ping robbevanherck.be"
# TODO: verify this
alias addvirtualcamera="sudo modprobe v4l2loopback devices=1 video_nr=1 card_label=\"RTMP server\" exclusive_caps=1"
alias addmicloopback="pactl load-module module-loopback latency_msec=1"

# Radio listening
alias stubru="mpv http://icecast.vrtcdn.be/stubru-high.mp3"
alias tijdloze="mpv http://icecast.vrtcdn.be/stubru_tijdloze-high.mp3"
alias willy="mpv https://playerservices.streamtheworld.com/api/livestream-redirect/WILLY.mp3"
alias vuurland="mpv http://icecast.vrtcdn.be/stubru_tgs-high.mp3"
alias untz="mpv http://icecast.vrtcdn.be/stubru_untz-high.mp3"

# Automatically use wlo1 interface
alias wpa_cli="wpa_cli -i wlo1"

# Bluetooth
alias bluetoothon="echo power on | bluetoothctl"
alias bluetoothoff="echo power off | bluetoothctl"
alias connectheadphones="echo connect D0:8A:55:33:74:F6 | bluetoothctl"

# Why use vim?
alias vim="nvim"
