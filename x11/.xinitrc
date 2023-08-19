#!/bin/sh
XSECURELOCK_SAVER=saver_xscreensaver
XSECURELOCK_XSCREENSAVER_PATH=/usr/lib/xscreensaver

cleanup() {
    pkill -TERM dunst
    pkill -TERM redshift
    rm -f ~/.Xauthority
}
trap cleanup INT TERM QUIT

# export MOZ_WEBRENDER=1
export MOZ_ACCELERATED=1


xrdb ~/.Xresources

setxkbmap -layout 'us,gr' \
    -option 'grp:alt_space_toggle,lv3:ralt_switch,terminate:ctrl_alt_bksp' \
    -variant nodeadkeys \
    -model pc105

xset b 0 0 0
xset r rate 350 35
xset dpms 0 0 0

xset s 300 5
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- env XSECURELOCK_SAVER=saver_xscreensaver xsecurelock &

redshift -t 6500:3250 -l 37.9869:23.8554  -m randr &
dunst -fn "JetBrains Mono 10" &

exec /usr/bin/x-window-manager
