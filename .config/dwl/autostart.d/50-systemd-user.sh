#!/bin/sh
# ==============================
# Systemd Environment
# ==============================

systemctl --user set-environment XDG_CURRENT_DESKTOP=dwl
systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

hash dbus-update-activation-environment 2>/dev/null &&
  dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=dwl
