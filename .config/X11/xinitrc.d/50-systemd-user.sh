#!/bin/sh

# =========================
# Environment
# =========================

# Import X11 environment in systemd (as user)
systemctl --user import-environment DISPLAY ${XAUTHORITY+XAUTHORITY}

# Update D-Bus environment with X11
if command -v dbus-update-activation-environment >/dev/null 2>&1; then
  dbus-update-activation-environment DISPLAY XAUTHORITY
fi
