exec systemctl --user set-environment XDG_CURRENT_DESKTOP=dwl
exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

exec hash dbus-update-activation-environment 2>/dev/null && \
          dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=dwl
