xset r rate 250 50 s off dpms 0 0 0
xwallpaper --zoom ~/.picture
dbus-daemon --session --address=unix:path=/run/user/1000/bus &
dunst & pipewire & pipewire-pulse &
picom & fcitx5 & statusbar & exec dwm
