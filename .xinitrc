#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Select screen
xrandr --auto --dpi 96

# Custom keyboard settings
xkbcomp .Xkeymap $DISPLAY

# Set wallpaper
xwallpaper --zoom $HOME/.config/wallpaper/moon.jpg &

# Start xcompmgr for transparency
xcompmgr &

# Start tray
stalonetray &

# Start Seafile
seaf-cli start &

# Custom keybindings
# autokey-qt &

# Networkmanager Applet
nm-applet &

# Lock screen on suspend
xss-lock slock &

# Clipboard QT
copyq &

# Start keepassxc
keepassxc &

dunst &
unclutter &

# Start idle manager
$HOME/bin/xsidle.sh slock &

# Start dwm, reset dwm when quitting
while true; do
    # Log stderror to a file 
    # No error logging
    #dwm >/dev/null 2>&1
    ssh-agent dwm
done
