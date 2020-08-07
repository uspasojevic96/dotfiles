#!/bin/zsh

# From Manjaro's "Proper ~/.xinitrc"
# https://wiki.manjaro.org/index.php?title=Proper_~/.xinitrc_File
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Load .Xresources 
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Load notification daemon
dunst &

# Sleep a couple seconds here
# (work-around intel driver garbling my
# external monitor display settings below...)
sleep 2

bash /home/uros/screenswap.sh

# Set wallpaper(s)
nitrogen --restore &
#picom &
synergyc 192.168.10.51 &
export PATH=$PATH:/opt/bin

# Load window Manager
exec i3

