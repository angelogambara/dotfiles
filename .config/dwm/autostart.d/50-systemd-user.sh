#!/bin/sh
# ==============================
# Systemd Environment
# ==============================

systemctl --user import-environment DISPLAY ${XAUTHORITY+XAUTHORITY}

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
  dbus-update-activation-environment DISPLAY XAUTHORITY
fi
