#!/bin/sh

if xrandr --listactivemonitors | grep -q "$1"; then
  xrandr --output "$1" --off
else
  xrandr --output "$1" --auto
fi
