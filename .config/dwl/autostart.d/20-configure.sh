#!/bin/sh
# ==============================
# Preferences
# ==============================

# Draw the wallpaper
swaybg -i ~/.cache/wallpaper

# Turn off my other monitor
wlr-randr --output DisplayPort-1-2 --off
