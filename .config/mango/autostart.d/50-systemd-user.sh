#!/bin/sh
# ==============================
# Systemd Environment
# ==============================

# export XDG_SESSION_TYPE=wayland

DWL_DETECTED="$(pgrep -x dwl || true)"
MANGO_DETECTED="$(pgrep -x mango || true)"

# Ungly check. All that matters is that it works
if [ -n "$DWL_DETECTED" ]; then
  export XDG_CURRENT_DESKTOP=dwl

  systemctl --user set-environment XDG_CURRENT_DESKTOP=dwl
  systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

  hash dbus-update-activation-environment 2>/dev/null &&
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=dwl
elif [ -n "$MANGO_DETECTED" ]; then
  export XDG_CURRENT_DESKTOP=mango

  systemctl --user set-environment XDG_CURRENT_DESKTOP=mango
  systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

  hash dbus-update-activation-environment 2>/dev/null &&
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=mango
fi
