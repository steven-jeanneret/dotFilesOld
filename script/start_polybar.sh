#!/bin/sh
killall polybar
m=$(xrandr | grep "primary"| cut -d " " -f1)
MONITOR=$m polybar -r default