#!/bin/sh

cleanup() {
    pkill redshift dunst
    rm -f ~/.Xauthority
}
trap cleanup INT TERM QUIT

export LANG=en_US.UTF-8

# better two-finger touchpad scrolling
export MOZ_USE_XINPUT2=1
export MOZ_WEBRENDER=1
export MOZ_ACCELERATED=1
export NO_AT_BRIDGE=1


xrdb -load ~/.Xresources

setxkbmap -layout 'us,gr' \
    -option 'grp:alt_space_toggle,lv3:ralt_switch,terminate:ctrl_alt_bksp' \
    -variant nodeadkeys \
    -model pc105

xsetroot -solid "#a3ccbd"

xset b 0 0 0
xset r rate 250 50
xset dpms 0 0 0

xset s off
# xidle -timeout 600 -ne -program ~/bin/lock &

# if we have private ssh key(s), start ssh-agent and add the key(s)
if [ -z "$SSH_AGENT_PID" ] && [ -x /usr/bin/ssh-agent ]
then
        for k in id_rsa id_ecdsa id_ecdsa_sk id_ed25519 id_ed25519_sk id_dsa
        do
                if [ -f "$HOME/.ssh/$k" ]; then
                        eval `ssh-agent -s`
                        ssh-add < /dev/null
                        break
                fi
        done
fi

redshift -t 6500:3250 -l 37.9869:23.8554 -m randr &
dunst -fn "JetBrains Mono 11" &

exec cwm

if [ "$SSH_AGENT_PID" ]; then
        ssh-add -D < /dev/null
        eval `ssh-agent -s -k`
fi

cleanup
