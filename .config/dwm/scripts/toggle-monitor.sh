#!/bin/sh

if xrandr --listactivemonitors | grep -q DisplayPort-1-2; then
  xrandr --output DisplayPort-1-2  --off --right-of DP-2
else
  xrandr --output DisplayPort-1-2 --auto --right-of DP-2
fi
