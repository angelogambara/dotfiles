#!/bin/sh
# ==============================
# Idle Manager
# ==============================

swayidle -w \
  timeout 241 "swaymsg output eDP-1 dpms off" \
  resume "swaymsg output eDP-1 dpms on" \
  timeout 301 "pgrep -u $(id -u) -x swaylock || swaylock & systemctl suspend" \
  timeout  61 "pgrep -u $(id -u) -x swaylock && systemctl suspend" &
