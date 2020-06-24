#!/usr/bin/env bash

# List of apps to install by --install option.
APPS=(
    'git-all'
    'curl'
    'jq'
    'nmap'
    'tmux'
    'vim'
    'python-autopep8'
    'isort'
    'pylint'
    'tree'
    'pass'
    'gcc' 'g++' 'make' 'build-essential'
    'libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
     llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev \
     liblzma-dev python-openssl'
    'ipcalc'
    'xclip'
    'axel'
)

# List of dotfiles in repo to replace by --link option.
DOTFILES=(
    '.bash_aliases'
    '.gitconfig'
    '.tmux.conf'
    '.psqlrc'
    '.sqliterc'
    '.gitignore_global'
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
        ln -s $(pwd)/dotfiles/${file} ~/${file} \
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

    echo "Installing pyenv"
    curl https://pyenv.run | bash
    echo "Installing docker-compose"
    sudo curl -L \
        --url "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" \
        --output /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo curl -L \
        --url https://raw.githubusercontent.com/docker/compose/1.24.0/contrib/completion/bash/docker-compose \
        --output /etc/bash_completion.d/docker-compose
}

remove_snap(){
    snap remove snap-store gtk-common-themes gnome-3-{28,34}-1804
    snap remove core18
    sudo apt --yes purge snapd
    sudo rm -rf /snap
    sudo rm -rf /var/snap
    sudo rm -rf /var/lib/snapd
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

# If ran with sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

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
        "-rs"|"--remove-snap")
            remove_snap
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
