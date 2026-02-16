#!/bin/sh
USER_NAME=$(loginctl list-users --no-legend | awk '{print $2}')
USER_ID=$(id -u "$USER_NAME")
export XAUTHORITY=/run/user/"$USER_ID"/Xauthority

LID_STATE=$(cat /proc/acpi/button/lid/LID*/state | awk '{print $2}')

if [ "$1" = "pre" ]; then
  if [ "$LID_STATE" != "open" ]; then
    if pgrep -u "$USER_NAME" -x Xorg; then
      if ! pidof -s slock; then
        sudo -u "$USER_NAME" -E DISPLAY=:0 slock &
      fi
    fi
    sleep 1 # wait before exit
  fi
fi
