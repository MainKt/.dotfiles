#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run picom --no-fading-openclose
run lxpolkit
run dunst
run nm-applet
run cbatticon
run wmname LG3D
run blueman-applet
run kitty --title sysmon --class sysmon btop --utf-force
run xinput disable 17
run unclutter
run feh --bg-fill --randomize ~/pics/wallpapers/
sleep 3 && run volumeicon
