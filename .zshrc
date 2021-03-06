#!/bin/zsh
# ZSH Configuration

export PROMPT='%n@%B%m%b%f> '
export RPROMPT='${vcs_info_msg_0_}%b%f%~ '

if [[ $UID -eq 0 ]]; then
    export PROMPT='%m%B%%%b%f '
fi

export CLICOLOR=1
export LSCOLORS=ExGxFxDxCxDxDxhbhdacEc
export LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32"

export HISTFILE=$HOME/.history
export HISTSIZE=100000
export SAVEHIST=100000

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export PERL_BADLANG=0
unset LC_ALL

export PYTHONSTARTUP=$HOME/.pythonrc.py

export VIRTUALENV_HOME=$HOME/.virtualenvs
export WORKON_HOME=$VIRTUALENV_HOME

path=(~/bin /usr/local/sbin /usr/local/bin /usr/bin /usr/sbin  /bin /sbin $path)
typeset -U path

fpath=($fpath ~/.zsh/functions)
typeset -U fpath

if [[ $- == *i* ]]; then
    autoload colors; colors;
    autoload -U add-zsh-hook

    if whence dircolors >/dev/null; then
        alias ls='ls --color'
    fi

    alias grep='grep --color'
    alias cls='clear'
    alias sc='tmux attach'
    alias mc='mc -d -c'
    alias mcedit='mcedit -d -c'

    alias delpyc="find . -name '*.pyc' -delete"
    alias delds="find . -name '.DS_Store' -delete"

    alias rainbow='for color in {000..255}; do echo -n "\e[38;5;${color}m ${color} \e[0m";  done'

    autoload compinit
    compinit -c

    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion::complete:*' use-cache 1
    zstyle ':completion:*' menu select

    setopt nobeep
    setopt list_packed
    setopt transient_rprompt
    setopt hist_ignore_dups
    setopt hist_find_no_dups
    setopt hist_ignore_space
    setopt appendhistory
    setopt sharehistory
    setopt incappendhistory

    bindkey '^[[A' up-line-or-search
    bindkey '^[[B' down-line-or-search
    bindkey ' ' magic-space
    bindkey '^K' kill-region
    bindkey '^A' beginning-of-line
    bindkey '^E' end-of-line
    bindkey '^L' clear-screen
    bindkey '^H' backward-delete-char
    bindkey '^?' backward-delete-char
    bindkey '^[[3~' delete-char
    bindkey '^[[2~' overwrite-mode

    bindkey "\e[H" beginning-of-line
    bindkey "\e[F" end-of-line

    bindkey '\e[7~' beginning-of-line
    bindkey '\e[8~' end-of-line

    bindkey '^[[1~' beginning-of-line
    bindkey '^[[4~' end-of-line

    bindkey '^[[H' beginning-of-line
    bindkey '^[[F' end-of-line

    bindkey '^[OH' beginning-of-line
    bindkey '^[OF' end-of-line
    bindkey '^[O5H' beginning-of-line
    bindkey '^[O5F' end-of-line

    autoload -Uz vcs_info

    zstyle ':vcs_info:*' stagedstr '%F{28}●'
    zstyle ':vcs_info:*' unstagedstr '%F{11}●'
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' enable git

    for config_file ($HOME/.zsh/lib/*(N)); do
        source $config_file
    done

    precmd() {
        case $TERM in
            *xterm*|*rxvt*)
                print -Pn "\e]2;%n@%m:%~\a"
            ;;
        esac

        zstyle ':vcs_info:*' formats ' %F{green}%b%c%u %F{15}'

        vcs_info 2>/dev/null
    }

    setopt prompt_subst
    setopt promptsubst

    autoload -U promptinit
    promptinit
fi

[[ -e ~/.profile ]] && source ~/.profile
