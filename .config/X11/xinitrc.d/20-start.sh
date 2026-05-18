#!/bin/sh

# =========================
# Autostart Programs
# =========================

# Set your apps here
export BROWSER=com.brave.Browser
export STATUSBAR=dwmblocks
export TERMINAL=st

# List of programs to autostart
AUTOSTART="
dunst
dwmblocks
notify-checkupdates
picom
pipewire
rmddd
unclutter
"

log_dir=/tmp/programs
mkdir -p "$log_dir"

# Launch programs if not already running and redirect output
set -f
for program in $AUTOSTART; do
  pidof -sx "$program" || "$program" >"$log_dir/$program.log" 2>&1 &
done
set +f
