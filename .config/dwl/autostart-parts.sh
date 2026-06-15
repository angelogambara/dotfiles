#!/bin/sh

# Source each file in order
if [ -d "$XDG_CONFIG_HOME/dwl/wlrinitrc.d" ]; then
  for f in "$XDG_CONFIG_HOME/dwl/wlrinitrc.d"/?*.sh; do
    # shellcheck disable=1090
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
