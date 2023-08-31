#!/bin/sh

cleanup() {
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
xset dpms 300 400 500
xset s off

exec i3

cleanup
