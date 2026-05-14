#!/bin/sh

# =========================
# Start GNOME keyring
# =========================

# Start GNOME keyring
if ! pgrep 'gnome-keyring-daemon' | grep -v '--login'; then
  gnome-keyring-daemon --start --components=pkcs11,secrets 2>/dev/null
fi
