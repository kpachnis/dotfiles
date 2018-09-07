# vim: fdm=marker

# Options {{{

setopt no_global_rcs
setopt auto_cd
setopt auto_list
setopt pushd_ignore_dups
setopt complete_aliases
setopt hash_list_all
setopt extended_glob
setopt hist_ignore_dups
setopt clobber
setopt correct
setopt prompt_subst
setopt no_beep
setopt auto_pushd
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home

# }}}

# Environment {{{

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export WORDCHARS=${WORDCHARS//[&.;\/]}

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zhistory

DIRSTACKSIZE=10

path=(
    ~/bin
    ~/.local/bin
    /Applications/MacVim.app/Contents/bin
    /usr/local/MacGPG2/bin
    /usr/local/{bin,sbin}
    /bin
    /sbin
    /usr/{bin,sbin}
    /usr/games
    /usr/X11R6/bin
)

path=(${(u)^path:A}(N-/))
fpath=(${(u)^fpath:A}(N-/))

EDITOR=$(command -v vim || command -v vi)
export VISUAL=$EDITOR

export GPG_TTY=$(tty)

export PAGER=less

export PYTHONDONTWRITEBYTECODE=1
export PYTHONSTARTUP=~/.pythonrc

# }}}

# Prompt {{{

PROMPT='%m%(?.. %??)%(1j. %j&.) $(git_prompt) %(!..)%# '

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

compdef '_files -g "*.(asciidoc|md|mkd|markdown)"' pandoc
compdef '_files -g "*.yml"' ansible-playbook

compdef '_hosts' ansible
compdef '_hosts' dig
compdef '_hosts' fping

compdef gpg2=gpg

# }}}

# VCS {{{

if [[ -x $(command -v git) ]]; then
  autoload -Uz vcs_info

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' actionformats '%r@%b|%a% %S'
  zstyle ':vcs_info:*' formats '%r@%b%c%u %S'
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' stagedstr '+'
  zstyle ':vcs_info:*' unstagedstr '-'

  precmd() { vcs_info }
fi

# }}}

# Hooks {{{

autoload -U add-zsh-hook
[[ $TERM =~ xterm* ]] && add-zsh-hook precmd xterm_title

# }}}

# Aliases {{{

if [[ $EDITOR =~ vi ]]; then
    alias vi=$EDITOR
    alias view="$EDITOR -R"
fi

case $(uname -s) in
    Darwin|FreeBSD)
        alias ls='ls -G'
        ;;
    Linux)
        alias ls='ls --color=auto'
        ;;
    *)
        alias ls='ls -F'
        ;;
esac
alias l='ls -chlt'
alias cp='cp -i'
alias ctmp='find $TMP -ctime +10 -delete'
alias dot='ls -d .*(/,.)'
alias du1='du -h -d 1'
alias mv='mv -i'
alias rm='rm -i'
alias reload='source ~/.zshrc'
alias update_dotfiles='curl https://raw.githubusercontent.com/kpachnis/dotfiles/master/install.sh | sh -x -'

# }}}

# Functions {{{

today() { date +%Y%m%d }
timestamp() { date +%Y%m%d_%H%M%S }
xterm_title() { print -Pn "\e]0; %n@%m:%~ \a" }

path() {
    for dir in $path; do
        print $dir
    done
}

enc() {
    openssl aes-256-cbc -salt -a -e -in $1 -out $1.enc
}

dec() {
    openssl aes-256-cbc -a -d -in $1 -out ${1:r}
}

git_prompt() {
    if [[ -n ${vcs_info_msg_0_} ]]; then
        print ":: ${vcs_info_msg_0_}"
    else
        print '%3~'
    fi

}

proxy() {
    if [[ -f ~/.proxy ]]; then
        source ~/.proxy
    else
        print "Proxy settings not found"
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
                    printf "%s \t-> %s\n" $proxy $(printenv $proxy)
                done
                printf "%s \t-> %s\n" NO_PROXY $(printenv NO_PROXY)
                printf "%s \t-> %s\n" no_proxy $(printenv no_proxy)

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

watch=(notme)
PERIOD=3600
periodic() { rehash }
bindkey -e

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# }}}

# Tools {{{

if [[ -d /usr/local/go ]]; then
    export GOPATH=~/go
    path+=(/usr/local/go/bin $GOPATH/bin)
fi

# }}}

