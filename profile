export PS1=$([ "$USER" = 'root' ] && echo '# ' || echo '$ ')
export PATH=~/Documents/'GitHub Repos'/dotfiles/local/bin:"$PATH"
export ANDROID_USER_HOME=~/.android LC_COLLATE=C

export XDG_STATE_HOME=~/.local/state
export XDG_CONFIG_HOME=~/.config
export XDG_RUNTIME_DIR=/run/user/1000
export XDG_DATA_HOME=~/.local/share
export XDG_CACHE_HOME=~/.cache

export DBUS_SESSION_BUS_ADDRESS=unix:path="$XDG_RUNTIME_DIR"/bus
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR"/gnupg/S.gpg-agent.ssh

export HISTFILE=/dev/null
export MYSQL_HISTFILE=/dev/null
export PYTHONHISTFILE=/dev/null
