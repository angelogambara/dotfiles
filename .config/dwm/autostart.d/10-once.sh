#!/bin/sh

# =========================
# Run Once
# =========================

# Dynamically set wallpaper with a script
setbg ~/.cache/wallpaper

# Load X11 color scheme
xrdb -load ~/.config/X11/gruvbox-dark.xresources

# Set keyboard repeat rate (delay 200ms, repeat 40/sec)
xset r rate 200 40

# Turn off the display after 180 seconds
xset dpms 0 0 180

# Disable my second monitor
xrandr --output DisplayPort-1-2 --off 2>/dev/null
