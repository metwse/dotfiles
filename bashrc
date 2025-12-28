if [[ $- != *i* ]]; then
    return
fi

export EDITOR=nvim
export VISUAL=nvim
export PAGER='nvim +Man!'
export MANPAGER='nvim +Man!'

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias vim=nvim
alias vi=nvim

if [[ -z "$TMUX" ]]; then
    while true; do
        { read -r query; read -r key; read -r sel; } < \
            <(tmux ls 2>/dev/null |
                sed "s/^[^:]*:/$(tput setaf 1 bold)&$(tput sgr0)/" |
                fzf --ansi --expect='ctrl-y,ctrl-r,enter' --print-query \
                --layout='reverse' --prompt='tmux: ' \
                --no-separator --no-info \
                --color='prompt:bold:bright-green,pointer:bold:bright-red')

        if [[ "$key" == "ctrl-r" ]]; then
            :  # noop, ctrl-r for refreshing the sessions list
        elif [[ -n "$key$query$sel" ]]; then
            if [[ "$key" == "ctrl-y" ]]; then
                if [[ -z "$query" ]]; then
                    tmux new-session
                else
                    tmux new-session -s "$query"
                fi
            elif [[ "$key" == "enter" && -z "$query$sel" ]]; then
                tmux new-session
            else
                session_name="${sel%%:*}"
                tmux new-session -A -s "${session_name:-$query}"
            fi
        else
            break
        fi
    done
fi
