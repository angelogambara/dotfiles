#!/bin/sh
# Centralized location for setting statusbar theme.

# ########
# Colors
# ########

# 4 grayscale
gray1=#1d2021
gray2=#928374
gray3=#a89984
gray4=#ebdbb2

# 3 normal colors
green=#98971a
yellow=#d79921
orange=#d65d0e

# 2 special cases
red=#cc241d
aqua=#689d6a

##########
# Main
##########

sourced_from="$(basename "$0")"

case "$sourced_from" in
sb-date)
  theme="^c${gray1}^^b${gray4}^"
  ;;
sb-battery)
  if [ "${capacity:-0}" -le 15 ]; then
    theme="^c${gray1}^^b${red}^"
  else
    theme="^c${gray1}^^b${yellow}^"
  fi
  ;;
sb-network)
  theme="^c${gray1}^^b${yellow}^"
  ;;
sb-volume)
  theme="^c${gray1}^^b${yellow}^"
  ;;
sb-brightness)
  theme="^c${gray1}^^b${yellow}^"
  ;;
sb-gpu)
  theme="^c${gray1}^^b${green}^"
  ;;
sb-cpu)
  theme="^c${gray1}^^b${green}^"
  ;;
sb-memory)
  theme="^c${gray1}^^b${green}^"
  ;;
sb-cpuall)
  theme="^c${gray1}^^b${green}^"
  ;;
sb-swap)
  theme="^c${gray1}^^b${green}^"
  ;;
sb-bluetooth)
  theme="^c${gray1}^^b${orange}^"
  ;;
sb-mail)
  theme="^c${gray1}^^b${orange}^"
  ;;
sb-disk)
  theme="^c${gray1}^^b${orange}^"
  ;;
sb-count)
  theme="^c${gray1}^^b${orange}^"
  ;;
*)
  die "Error: Unknown status bar module"
  ;;
esac
reset="^b${gray1}^"
