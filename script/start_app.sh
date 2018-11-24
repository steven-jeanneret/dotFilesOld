#!/bin/sh
autorandr --change
sleep 1
feh --bg-fill ~/.background/lockscreen.png #Fond d'écran
~/.script/start_polybar.sh