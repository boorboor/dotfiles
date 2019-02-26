#!/usr/bin/env bash

# List of apps to install by --install option.
APPS=(
    'git-all'
    'curl'
    'nmap'
    'tmux'
    # 'ipcalc'
    # 'xclip'
    # 'axel'
)

# List of dotfiles in repo to replace by --link option.
DOTFILES=(
    '.bash_aliases'
    '.gitconfig'
    '.tmux.conf'
    '.psqlrc'
    '.vim/'
)

link(){
    clear
    echo "linking dotfiles..."
    for file in ${*}
    do
        if [ -f ~/${file} ]; then
            mv ~/${file} ~/${file}.old
        fi
        ln -sf $(pwd)/dotfiles/${file} ~/${file} \
            &&echo "${file} file linked" \
            || echo "${file} fail to link."
    done
}

unlink(){
    clear
    echo "unlinking dotfiles..."
    for file in ${*}
    do
        if [ -f ~/${file} ]; then
            unlink ~/${file}
            mv ~/${file}.old ~/${file}
        fi
    done
}
install(){
    clear
    apt update
    for app in ${*}
    do
        which ${app} >/dev/null \
            ||apt install -qq ${app} -y \
            &&echo "${app} already is installed."
    done
}

help(){
    clear
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  -l, --link        Linking dotfiles from home."
    echo "  -i, --install     Installs list of my favorite packages."
    echo "  -h, --help        Shows this message."
    echo ""
}

trap '' 0 1 2 3 6 14 15

if [[ $# == 0 ]]; then
    clear
    echo ""
    echo "No option is provided please use one of available options."
    echo ""
    help
    exit 1
fi

while [[ $# -gt 0 ]]
do
    case $1 in
        "-l"|"--link")
            link ${DOTFILES[*]}
            ;;
        "-u"|"--unlink")
            unlink ${DOTFILES[*]}
            ;;
        "-i"|"--install")
            install ${APPS[*]}
            ;;
        "-h"|"--help")
            help
            exit
            ;;
        *)
            echo ""
            echo "Invalid option is provided please use one of available options."
            echo ""
            help
            exit 1
            ;;
    esac
    shift
done
