#!/bin/sh

# =========================
# Start D-Bus
# =========================

if [ "$(ps -p 1 -o comm=)" != 'systemd' ]; then
  dbus-daemon --session --address=unix:path="$XDG_RUNTIME_DIR"/bus &
  export DBUS_SESSION_BUS_ADDRESS=unix:path="$XDG_RUNTIME_DIR"/bus
fi
