#!/usr/bin/env sh

### Merge defaults and load keymaps
SYS_RESOURCES=/etc/X11/xinit/.Xresources
SYS_MODMAP=/etc/X11/xinit/.Xmodmap
USER_RESOURCES=$HOME/.Xresources
USER_MODMAP=$HOME/.Xmodmap
[ -f "$SYS_RESOURCES"  ] && xrdb -merge "$SYS_RESOURCES"
[ -f "$SYS_MODMAP"     ] && xmodmap     "$SYS_MODMAP"
[ -f "$USER_RESOURCES" ] && xrdb -merge "$USER_RESOURCES"
[ -f "$USER_MODMAP"    ] && xmodmap     "$USER_MODMAP"
unset SYS_RESOURCES \
      SYS_MODMAP    \
      USER_RESOURCES\
      USER_MODMAP

### Handle /etc/xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for F in /etc/X11/xinit/xinitrc.d/?*; do
    [ -x "$F" ] && . "$F"
  done
  unset F
fi

### Load xprofiles (not needed with display manager)
[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile   ] && source ~/.xprofile

### Load environment
#/home/milesbhuff/.local/bin/readenv.bash
export SESSION_MANAGER=

### WM or DE to execute
#exec /usr/bin/awesome -c ~/.config/awesome/rc.lua
exec /usr/bin/startxfce4
#exec terminator -bmf --geometry="$(xrandr | grep 'connected' | awk '{print $3}')"
