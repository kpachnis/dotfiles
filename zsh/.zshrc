# vim: fdm=marker

# Options {{{

setopt no_global_rcs
setopt auto_cd
setopt auto_list
setopt pushd_ignore_dups
setopt complete_aliases
setopt hash_list_all
setopt extended_glob
setopt clobber
setopt correct
setopt prompt_subst
setopt no_beep
setopt auto_pushd
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home

setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history


# }}}

# Environment {{{

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export WORDCHARS=${WORDCHARS//[&.;\/]}

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zhistory
HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"

DIRSTACKSIZE=10

case $(uname -s) in
    Linux)
        export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
        export NO_AT_BRIDGE=1
        ;;
    Darwin)
        eval "$(/usr/libexec/path_helper)"
        ;;
esac

path=(
    ~/bin
    ~/.local/bin
    /opt/homebrew/{bin,sbin}
    /opt/homebrew/opt/{coreutils,findutils}/libexec/gnubin
    $path
)

path=(${(u)^path:A}(N-/))
fpath=(${(u)^fpath:A}(N-/))

EDITOR=$(command -v helix || command -v hx || command -v nvim || command -v vim || command -v vi)
export VISUAL=$EDITOR

export GPG_TTY=$(tty)

export PAGER=less
export LESS="-r"

export PYTHONDONTWRITEBYTECODE=1
export PYTHONSTARTUP=~/.pythonrc

# }}}

# Prompt {{{

PROMPT='$(__prompt) %(!.#.>) '

# }}}

# Completion {{{

zstyle ':completion::*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion::complete:*' rehash true
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:*:kill:*:processes' '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER"

autoload -U compinit
compinit

# }}}

# VCS {{{

if [[ -x $(command -v git) ]]; then
  autoload -Uz vcs_info

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' actionformats "%r %F{3}%b%f|%a% %S"
  zstyle ':vcs_info:*' formats "%r %F{3}%b%f%c%u %S"
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' stagedstr "%F{1}+%f"
  zstyle ':vcs_info:*' unstagedstr "%F{1}-%f"

  precmd() { vcs_info }
fi

# }}}

# Hooks {{{

autoload -U add-zsh-hook
[[ $TERM =~ (xterm*|alacritty|foot) ]] && add-zsh-hook precmd xterm_title

# }}}

# Aliases {{{

[[ $TERM != xterm* ]] && alias ssh='TERM=xterm-256color ssh'

alias ls='ls --color=auto'
alias l='ls -chlt'
alias cp='cp -i'
alias dot='ls -d .*(/,.)'
alias du1='du -h -d 1'
alias mv='mv -i'
alias rm='rm -i'
alias reload='source ~/.zshrc'
alias tree='tree -C'
alias bc='bc -l'

# }}}

# Functions {{{

xterm_title() { print -Pn "\e]0;%m \a" }

__prompt() {
    if [[ -n ${vcs_info_msg_0_} ]]; then
        print "${vcs_info_msg_0_}"
    else
        print "%m:%F{2}%3~%f"
    fi

}

proxy() {
    if [[ -f ~/.proxy ]]; then
        source ~/.proxy
    else
        print "$fg[red]Proxy settings not found$reset_color"
        return
    fi

    typeset -a proxies
    proxies=(HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY http_proxy https_proxy ftp_proxy rsync_proxy)

    while getopts edsh opt; do
        case $opt in
            e)
                for proxy in $proxies; do
                    export $proxy=$PROXY
                done
                export NO_PROXY
                export no_proxy=$NO_PROXY

                break
                ;;
            d)
                for proxy in $proxies; do
                    unset $proxy
                done
                unset NO_PROXY
                unset no_proxy

                break
                ;;
            s)
                for proxy in $proxies; do
                    printf "%s: %s\n" $proxy $(printenv $proxy)
                done
                printf "%s: %s\n" NO_PROXY $(printenv NO_PROXY)
                printf "%s: %s\n" no_proxy $(printenv no_proxy)

                break
                ;;
            h)
                printf "Usage: proxy [-e] [-d] [-s]\n"

                break
                ;;
        esac
    done

    shift $(( OPTIND - 1 ))

    [ $# = 0 ] && printf "Usage: proxy [-e] [-d] [-s]\n"

    unset PROXY
}

# }}}

# Misc {{{

autoload zcalc

watch=(notme)
PERIOD=3600
periodic() { rehash }

bindkey -e

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# }}}
