export XDG_CACHE_HOME=~/.cache XDG_CONFIG_HOME=~/.config XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state XDG_RUNTIME_DIR=/run/user/1000

export DBUS_SESSION_BUS_ADDRESS=unix:path="$XDG_RUNTIME_DIR"/bus
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR"/gnupg/S.gpg-agent.ssh

export PATH=~/dotfiles/local/bin:"$PATH"
export PS1=$([ "$USER" = 'root' ] && echo '# ' || echo '$ ')

export LESSHISTFILE=/dev/null
export HISTFILE=/dev/null
export MYSQL_HISTFILE=/dev/null

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
