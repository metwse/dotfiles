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

FZF_THEME='--ansi --layout=reverse --no-separator --no-info
           --color=prompt:bold:bright-green,pointer:bold:bright-red'

connect-container() {
    sudo docker exec -e TERM=$TERM -it "$1" bash
    if [[ "$?" != '0' ]]; then
        sleep 1
    fi
}

docker-container-selection() {
    xtitle -qt 'pending authorization...'
    sudo -v

    while true; do
        xtitle -qt 'docker container selection'
        { read -r key; read -r sel; } < <(
            sudo docker ps --format "$(tput setaf 1 bold){{.Names}}:$(tput sgr0) {{.Image}} (created {{.RunningFor}})" |
            fzf --expect='ctrl-y,ctrl-r,ctrl-j,ctrl-d,enter' --prompt='docker: ' \
                $FZF_THEME
        )

        if [[ "$key" == 'ctrl-r' ]]; then
            :  # noop, ctrl-r for refreshing the container list
        elif [[ "$key" == 'ctrl-d' ]]; then
            exit 0
        elif [[ "$key" == 'ctrl-j' ]]; then
            tmux-session-selection
            return
        elif [[ -n "$key$sel" ]]; then
            if [[ "$key" == 'ctrl-y' || "$key" == 'enter' ]]; then
                container_name="${sel%%:*}"
                xtitle -qt "container $container_name"
                connect-container "$container_name"
            fi
        else
            break
        fi
    done
}

tmux-session-selection() {
    if [[ -n "$TMUX" ]]; then
        return
    fi

    while true; do
        xtitle -qt 'tmux session selection'
        { read -r query; read -r key; read -r sel; } < <(
            tmux ls 2>/dev/null |
            sed "s/^[^:]*:/$(tput setaf 1 bold)&$(tput sgr0)/" |
            fzf --expect='ctrl-y,ctrl-r,ctrl-j,ctrl-d,enter' --prompt='tmux: ' \
                --print-query $FZF_THEME
        )

        if [[ "$key" == 'ctrl-r' ]]; then
            :  # noop, ctrl-r for refreshing the sessions list
        elif [[ "$key" == 'ctrl-d' ]]; then
            exit 0
        elif [[ "$key" == 'ctrl-j' ]]; then
            docker-container-selection
            return
        elif [[ -n "$key$query$sel" ]]; then
            if [[ "$key" == 'ctrl-y' ]]; then
                if [[ -z "$query" ]]; then
                    xtitle -qt 'Terminal'
                    tmux new-session
                else
                    xtitle -qt "$query"
                    tmux new-session -s "$query"
                fi
            elif [[ "$key" == 'enter' && -z "$query$sel" ]]; then
                xtitle -qt 'Terminal'
                tmux new-session
            else
                session_name="${sel%%:*}"
                : "${session_name:=$query}"
                xtitle -qt "$session_name"
                tmux new-session -A -s "$session_name"
            fi
        else
            break
        fi
    done
}

tmux-session-selection
