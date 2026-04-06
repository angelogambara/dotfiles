#!/bin/sh
# shellcheck disable=SC2034

# ########
# Colors
# ########

# Colors from dwm
gray1="#1d2021"
gray2="#928374"
gray3="#a89984"
gray4="#ebdbb2"

# Normal colors
red="#cc241d"
green="#98971a"
yellow="#d79921"
blue="#458588"
purple="#b16286"
cyan="#689d6a"
orange="#d65d0e"

##########
# Helper
##########

die() {
  echo >&2 "$1"
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1 || return 1
}

check_env() {
  # Make zsh behave more like POSIX
  emulate sh 2>/dev/null

  # Prevent root from running
  [ "$(id -u)" -eq 0 ] && die "Do not run as root"

  # Ensure environment variables are set
  if [ -z "$STATUSBAR" ]; then
    die "STATUSBAR is unset"
  fi

  # Ensure this script is not misused
  basename=$(basename "$0")
  if [ "$basename" = "gruvbox-dark.sh" ]; then
    die "Error: This script must be sourced"
  fi
}

##########
# Main
##########

check_env

# Handle statusbar specific logic
case "$STATUSBAR" in
dwmblocks)
  # The name of the script sourcing this file
  case "$basename" in
  sb-date)
    theme="^c${gray1}^^b${gray4}^"
    ;;
  sb-battery)
    # shellcheck disable=SC2154
    if [ "$capacity" -le 15 ]; then
      theme="^c${gray1}^^b${red}^"
    else
      theme="^c${gray1}^^b${yellow}^"
    fi
    ;;
  sb-network)
    theme="^c${gray1}^^b${orange}^"
    ;;
  sb-volume)
    theme="^c${gray1}^^b${yellow}^"
    ;;
  sb-brightness)
    theme="^c${gray1}^^b${yellow}^"
    ;;
  sb-mail)
    theme="^c${gray1}^^b${green}^"
    ;;
  sb-bluetooth)
    theme="^c${gray1}^^b${orange}^"
    ;;
  sb-cpu)
    theme="^c${gray1}^^b${orange}^"
    ;;
  sb-gpu)
    theme="^c${gray1}^^b${orange}^"
    ;;
  sb-memory)
    theme="^c${gray1}^^b${green}^"
    ;;
  sb-swap)
    theme="^c${gray1}^^b${purple}^"
    ;;
  sb-disk)
    theme="^c${gray1}^^b${purple}^"
    ;;
  *)
    die "Error: Unknown status bar module"
    ;;
  esac
  reset="^b${gray1}^"
  ;;
somebar)
  # The name of the script sourcing this file
  case "$basename" in
  sb-date)
    theme="<span background='$gray4'>"
    ;;
  sb-battery)
    # shellcheck disable=SC2154
    if [ "$capacity" -le 15 ]; then
      theme="<span background='$red'>"
    else
      theme="<span background='$yellow'>"
    fi
    ;;
  sb-network)
    theme="<span background='$orange'>"
    ;;
  sb-volume)
    theme="<span background='$yellow'>"
    ;;
  sb-brightness)
    theme="<span background='$orange'>"
    ;;
  sb-mail)
    theme="<span background='$green'>"
    ;;
  sb-bluetooth)
    theme="<span background='$purple'>"
    ;;
  sb-cpu)
    theme="<span background='$blue'>"
    ;;
  sb-gpu)
    theme="<span background='$blue'>"
    ;;
  sb-memory)
    theme="<span background='$aqua'>"
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
