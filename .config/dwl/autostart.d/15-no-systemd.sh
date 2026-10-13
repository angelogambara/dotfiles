#!/bin/sh

# =========================
# No Systemd
# =========================

# Skip if running systemd
if [ "$(ps -p 1 -o comm=)" != 'systemd' ]; then
  DBUS_DETECTED="$(pgrep -a 'dbus-daemon' | grep -q -- '--session' | grep -q -- '--address')"
  KEYRING_DETECTED="$(pgrep -a 'gnome-keyring' | grep -qv -- '--login')"
  FOOT_DETECTED="$(pgrep -a 'foot' | grep -qv -- '--server')"

  # Start Foot
  [ -z "$FOOT_DETECTED" ] && foot --server >/tmp/programs/foot.log 2>&1 &

  # Manually export D-Bus
  export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

  # Start D-Bus
  if [ -z "$DBUS_DETECTED" ]; then
    dbus-daemon --session --address="${DBUS_SESSION_BUS_ADDRESS}" &
  fi

  # Start GNOME Keyring
  if [ -z "$KEYRING_DETECTED" ]; then
    gnome-keyring-daemon --start --components='secrets' >/tmp/programs/gnome-keyring.log 2>&1
  fi

  # Start pipewire
  pidof -sx pipewire || pipewire >/tmp/programs/pipewire.log 2>&1 &
fi
