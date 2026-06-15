#!/bin/sh

# =========================
# Void Linux
# =========================

# Autostart D-Bus, PipeWire and GNOME Keyring
if [ "$(ps -p 1 -o comm=)" != 'systemd' ]; then
  export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

  if ! pgrep -a 'dbus-daemon' | grep -q -- '--session' | grep -q -- '--address'; then
    dbus-daemon --session --address="${DBUS_SESSION_BUS_ADDRESS}" &
  fi

  pidof -sx pipewire || pipewire >/tmp/programs/pipewire.log 2>&1 &

  if ! pgrep -a 'gnome-keyring' | grep -qv -- '--login'; then
    gnome-keyring-daemon --start --components='secrets' >/dev/null 2>&1
  fi
fi
