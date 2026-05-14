#!/bin/sh

# =========================
# Preferences
# =========================

# Draw the wallpaper
feh --no-fehbg --bg-fill ~/.cache/wallpaper

# Turn off my other monitor
xrandr --output DisplayPort-1-2 --off

# Set X11 color scheme to gruvbox-dark
xrdb -load ~/.config/X11/gruvbox-dark.xresources

# Set keyboard repeat rate (delay 200ms, repeat 40/sec)
xset r rate 200 40

# Turn off the display after 3 minutes
xset dpms 0 0 180
