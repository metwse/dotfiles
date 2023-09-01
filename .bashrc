# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=4000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
       xterm*|rxvt*)
        PS1="\[\e]0;\${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;; *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


alias vim="nvim"
alias vi="nvim"

export EDITOR=nvim
export VISUAL=nvim
export PAGER='nvim +Man!'
export MANPAGER='nvim +Man!'


cNC='\033[0m'
cBOLD='\033[1m'
cbBLACK='\033[1;30m'    cBLACK='\033[0;30m'
cbRED='\033[1;31m'      cRED='\033[0;31m'
cbGREEN='\033[1;32m'    cGREEN='\033[0;32m'
cbORANGE='\033[1;33m'   cORANGE='\033[0;33m'
cbBLUE='\033[1;34m'     cBLUE='\033[0;34m'
cbPURPLE='\033[1;35m'   cPURPLE='\033[0;35m'
cbCYAN='\033[1;36m'     cCYAN='\033[0;36m'
cbGRAY='\033[1;37m'     cGRAY='\033[0;37m'


if [[ -z "$TMUX" ]]; then 
    set -m

    update_input() {
        tput sc
        if [ $line_count = 0 ]; then tput cup $line_count 0
        else tput cup $(($line_count + 1)) 0; fi
        echo -en '\033[2K'
        printf "${color}$mode${cNC}  $SESSION"
        tput rc
    }
    focus_input() {
        if [ $line_count = 0 ]; then set_row 0 $((${#mode} + ${#SESSION} + 2))
        else set_row $(($line_count + 1)) $((${#mode} + ${#SESSION} + 2)); fi
    }
    set_row() {
        row=$1
        tput cup $1 $2
    }

    while true; do
        clear
        tmux list-sessions | grep '^.*: '

        mode='new'
        color=$cbGREEN

        SESSION=''

        line_count=$(tmux list-sessions -F '.' | wc -l)
        update_input
        if [ $line_count != 0 ]; then set_row $line_count
        else focus_input; fi


        while true; do
            if [ $line_count = 0 ]; then update_input; focus_input; fi
            read -rsn1 key
            read -rsn1 -t 0.001 key1
            read -rsn1 -t 0.001 key2
            key+="$key1$key2"

            if [ $line_count != $(tmux list-sessions -F '.' | wc -l) ]; then mode='none'; break; fi

            case $key in
                   '␄') # C-d exit 
                    exit
                ;; '␡') # <BS> backspace
                    if [ ${#SESSION} -gt 0 ]; then
                        SESSION=${SESSION::-1}
                        update_input; focus_input
                    fi
                ;; '␋') # C-k kill
                    mode='kill'; color=$cbRED
                    update_input
                ;; '␎') # C-n new
                    mode='new'; color=$cbGREEN 
                    update_input
                ;; '␘') # C-x top
                    set_row 0
                ;; '␚') # C-z bottom
                    set_row $(($line_count - 1))
                ;;'␛' ) # esc reset
                    SESSION=''
                    update_input
                    set_row $(($line_count - 1))
                ;; *)
                    if [ -z $key ]; then
                        if [ $line_count -gt 0 ]; then
                            if [ $row -le $line_count ]; then SESSION=$(tmux list-sessions -F '#{session_name}' | sed -n "$((row + 1))p"); fi
                        fi
                        break
                    elif echo $key | grep -q '^␛\[[ABCD]$'; then # arrow keys
                        if [ $line_count != 0 ]; then
                            case $key2 in
                                'A') if [ $row -ge 1 ]; then ((row--)); echo -n $key; fi;;
                                'B') if [ $row -le $line_count ]; then ((row++)); echo -n $key; fi;;
                                *) echo -n $key;;
                            esac
                        fi
                    else 
                        SESSION+=$key
                        update_input; focus_input
                    fi
                ;;
            esac
        done 

        clear
        case $mode in
               'new')
                if [ "$SESSION" = "debug" ]; then break
                elif [ $line_count != 0 ] && tmux list-sessions -F "#{session_name}" | grep -q "^$SESSION$"; then tmux attach-session -t "$SESSION" &
                else tmux new-session -e "SESSION_NAME=$SESSION" & fi
                fg tmux
            ;; 'kill')
                tmux kill-session -t "$SESSION"
            ;;
        esac
    done
fi

if [[ -n "$SESSION_NAME" ]]; then
    tmux rename-session "$SESSION_NAME"
fi
