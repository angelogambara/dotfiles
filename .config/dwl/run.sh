#!/bin/sh

if [ -d ~/.config/dwm/autostart.d ]; then
  for f in ~/.config/dwm/autostart.d/?*.sh; do
    # shellcheck disable=1090
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Replace shell with the compositor
exec dwl
