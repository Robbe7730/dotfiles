#!/bin/bash

function print_help {
   echo "USAGE: $0 [-h] [-v] [--no-<service>]"
   echo "    -h: Print this help and exit"
   echo "    -v: Be more verbose"
   echo "    --no-<service>: Don't install <service>"
}

function verbose_echo {
    if [ "$VERBOSE" == "y" ]; then
        echo "$@"
    fi
}

CONFIG_BASE=~/.files/configs

DONT_INSTALL=()
VERBOSE=n

INSTALL_NAMES=()
INSTALL_SRC=()
INSTALL_DEST=()

while IFS=$'\t' read -r -a line; do
    INSTALL_NAMES+=(${line[0]})
    INSTALL_SRC+=(${line[1]})
    INSTALL_DEST+=(${line[2]})
done < ./configs/targets.tsv

while [ "$#" != "0" ]; do
    case $1 in
        --no-*)
            DONT_INSTALL+=(${1:5})
        ;;
        -v)
            VERBOSE=y
        ;;
        -?)
            print_help
            exit 0
        ;;
        *)
            echo "Invalid argument: $1"
            print_help
            exit 1
        ;;
    esac
    shift
done

verbose_echo Verbose is on
verbose_echo Not installing "(${DONT_INSTALL[*]})"

for ((i = 0; i < ${#INSTALL_NAMES[*]}; i++)); do
    name=${INSTALL_NAMES[$i]}
    src=${INSTALL_SRC[$i]}
    dest=${INSTALL_DEST[$i]}
    dest=${dest/#\~/$HOME}

    verbose_echo "---- $name ($src) ---"
    if [[ ${DONT_INSTALL[*]} =~ (^|[[:space:]])"$name"($|[[:space:]]) ]]; then
        verbose_echo Skipping...
        verbose_echo
        continue
    fi


    if [ "$VERBOSE" == "y" ]; then
        ln -svfT "$CONFIG_BASE/$src" "$dest"
    else
        ln -sfT "$CONFIG_BASE/$src" "$dest"
    fi

    verbose_echo
done
