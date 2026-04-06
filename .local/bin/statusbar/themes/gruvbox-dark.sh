#!/bin/sh

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

# Handle statusbar specific logic
case "$STATUSBAR" in
dwmblocks)
  # The name of the script sourcing this file
  case $(basename "$0") in
  sb-date)
    theme="^c${gray1}^^b${gray4}^"
    ;;
  sb-battery)
    if [ -n "$capacity" ]; then
      if [ "$capacity" -le 15 ]; then
        theme="^c${gray1}^^b${red}^"
      else
        theme="^c${gray1}^^b${yellow}^"
      fi
    else
      die "Error: capacity is not set"
    fi
    ;;
  sb-volume)
    theme="^c${gray1}^^b${yellow}^"
    ;;
  sb-brightness)
    theme="^c${gray1}^^b${yellow}^"
    ;;
  sb-network)
    theme="^c${gray1}^^b${orange}^"
    ;;
  sb-bluetooth)
    theme="^c${gray1}^^b${orange}^"
    ;;
  sb-cpu)
    theme="^c${gray1}^^b${orange}^"
    ;;
  sb-memory)
    theme="^c${gray1}^^b${green}^"
    ;;
  sb-mail)
    theme="^c${gray1}^^b${green}^"
    ;;
  sb-swap)
    theme="^c${gray1}^^b${aqua}^"
    ;;
  sb-disk)
    theme="^c${gray1}^^b${aqua}^"
    ;;
  *)
    die "Error: Unknown status bar module"
    ;;
  esac
  reset="^b${gray1}^"
  ;;
somebar)
  # The name of the script sourcing this file
  case $(basename "$0") in
  sb-date)
    theme="<span background='$gray4'>"
    ;;
  sb-battery)
    if [ -n "$capacity" ]; then
      if [ "$capacity" -le 15 ]; then
        theme="<span background='$red'>"
      else
        theme="<span background='$yellow'>"
      fi
    else
      die "Error: capacity is not set"
    fi
    ;;
  sb-volume)
    theme="<span background='$yellow'>"
    ;;
  sb-brightness)
    theme="<span background='$yellow'>"
    ;;
  sb-network)
    theme="<span background='$orange'>"
    ;;
  sb-bluetooth)
    theme="<span background='$orange'>"
    ;;
  sb-cpu)
    theme="<span background='$orange'>"
    ;;
  sb-memory)
    theme="<span background='$green'>"
    ;;
  sb-mail)
    theme="<span background='$green'>"
    ;;
  sb-swap)
    theme="<span background='$aqua'>"
    ;;
  sb-disk)
    theme="<span background='$aqua'>"
    ;;
  *)
    die "Error: Unknown status bar module"
    ;;
  esac
  reset="</span>"
  ;;
*)
  die "Error: Statusbar not supported"
  ;;
esac
