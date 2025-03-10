export PATH="$HOME"/dotfiles/local/bin:"$PATH"
export PS1=$([ "$USER" = 'root' ] && echo '# ' || echo '$ ')

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_RUNTIME_DIR=/run/user/1000

export DBUS_SESSION_BUS_ADDRESS=unix:path="$XDG_RUNTIME_DIR"/bus
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR"/gnupg/S.gpg-agent.ssh

export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_THEME=Adwaita:dark
export GTK_IM_MODULE=fcitx
