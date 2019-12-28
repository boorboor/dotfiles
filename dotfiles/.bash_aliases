# Colors
SWITCH="\[\033["
NORMAL="${SWITCH}0;00m\]"
RED="${SWITCH}0;31m\]"
GREEN="${SWITCH}32m\]" # bold
YELLOW="${SWITCH}0;33m\]"
BLUE="${SWITCH}0;34m\]"
CYAN="${SWITCH}0;36m\]"
WHITE="${SWITCH}1;39m\]" # Bold

export EDITOR=/usr/bin/vim

alias lf='ls -AlhF'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias clipboard='xclip -selection clipboard'
alias myip1='curl icanhazip.com'
alias myip2='curl ifconfig.me'
alias myip3='curl ipecho.net/plain'
alias TODO='grep -rin TODO'
alias note='vim ~/Documents/note.txt'
alias ports='ss -tul4np'
alias p8='ping 8.8.8.8 -c 3'
alias m8='mtr 8.8.8.8'
alias pyserv='sudo python3 -m http.server 80'
alias khamosh='shutdown now'

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "|${BRANCH}${STAT}|"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# workspace switcher
function ws(){
    if [ $# -lt 1 ]; then
        cd ~/Codes
        echo "  No workspace is given, you are in code area."
    elif [ -d ~/Codes/$1 ]; then
        cd ~/Codes/$1
        echo -e "  Switched to workspace \033[32m$1\033[0;00m, have a nice code time."
    else
        echo "There is on workspace named $1".
        echo "  options are:"
        ls -d ~/Codes/*/ |cut -d'/' -f5
        echo ""
    fi
}

function shecan(){
    if [ $# -lt 1 ]; then
        cat /etc/resolv.conf |grep nameserver
    elif [ $1 == 'on' ]; then
        sudo sed -i s/127.0.0.53/185.51.200.2/ /etc/resolv.conf && \
            echo 'nameservers set to shecan service'; grep nameserver /etc/resolv.conf
    elif [ $1 == 'off' ]; then
        sudo sed -i s/185.51.200.2/127.0.0.53/ /etc/resolv.conf && \
            echo 'nameservers set to shecan service'; grep nameserver /etc/resolv.conf
    fi
}

export PS1="${GREEN}\w${YELLOW}\$(parse_git_branch)${WHITE}\j${NORMAL}$ "

# start a tmux session
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

