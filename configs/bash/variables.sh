# Bash settings
## Prompt string
export PS1='[\u@\h \W]\$ '
## Don't save commands executed multiple times in a row multiple times
export HISTCONTROL=ignoreboth
## More history
HISTSIZE=100000

# PATH
## ?
export PATH=$HOME/.local/bin:$PATH
## Ruby-related
export PATH=$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
## Rust/cargo installations
export PATH=$HOME/.cargo/bin:$PATH
## Custom scripts
export PATH=$HOME/.files/scripts:$PATH
## Perl
export PATH=$HOME/perl5/bin:$PATH
## Redpencil mu-cli
export PATH=$HOME/Documents/redpencil.io/mu-cli/:$PATH
## go binaries
export PATH=$HOME/go/bin:$PATH
## doom emacs
export PATH=$HOME/.emacs.d/bin:$PATH

# ?
export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"

# easily go to the current semester folder
export huidigSemester="$HOME/Documents/UGent/Master/2021-2022/semester1/"

# Why use nano?
export EDITOR="nvim"

# Automatically use more jobs for Makefile
export MAKEFLAGS="-j4"

# Fix npm/NodeJS
export NODE_PATH=/usr/lib/node_modules/

# For GBA dev
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export DEVKITPPC=/opt/devkitpro/devkitPPC
export PATH=$DEVKITPRO/tools/bin:$PATH

# For CUDA
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64"
export CUDA_HOME=/opt/cuda/

# For jadx-gui
# export JADX_GUI_OPTS="-Dsun.java2d.uiScale=2"

# For Hledger
export LEDGER_FILE=~/.hledger/main.journal

# Terminal config
export TERM=xterm

# SSH with yubikey
export SSH_AUTH_SOCK=/tmp/ssh.socket
