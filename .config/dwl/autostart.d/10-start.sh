#!/bin/sh

# ==============================
# Autostart Programs
# ==============================

# Set your apps here
export BROWSER=firefox
export TERMINAL=alacritty

# List of programs to autostart
AUTOSTART="
dunst
notify-checkupdates
rmddd
waybar
"

log_dir=/tmp/programs
mkdir -p "$log_dir"

# Launch programs if not already running and redirect output
set -f
for program in $AUTOSTART; do
  pidof -sx "$program" || "$program" >"$log_dir/$program.log" 2>&1 &
done
set +f
