#!/bin/sh

# =========================
# Start GNOME keyring
# =========================

# Ensure GNOME keyring is running on Void Linux (requred by GnuPG pinentry)
if ! pgrep 'gnome-keyring-daemon' | grep -v '--login' ; then
  gnome-keyring-daemon --start --components='secrets' 2>/dev/null
fi
