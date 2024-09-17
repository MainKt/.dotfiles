#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run picom
run /usr/lib/mate-polkit/polkit-mate-authentication-agent-1
run dunst
run wmname LG3D
run alacritty --class sysmon -e btop
run unclutter
run feh --bg-scale --randomize ~/pics/wallpapers/
