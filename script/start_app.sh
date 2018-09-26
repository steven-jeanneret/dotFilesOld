#!/bin/sh
autorandr --change
sleep 1
feh --bg-fill ~/.background/background.jpg #Fond d'écran
~/.script/start_polybar.sh