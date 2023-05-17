export PATH=~/dotfiles/local/bin:$PATH
export PS1=$([ "$USER" = 'root' ] && echo '# ' || echo '$ ')

export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export XDG_CONFIG_HOME=~/.config
export XDG_STATE_HOME=~/.local/state

export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

export HISTFILE="$XDG_STATE_HOME"/hst
export RANDFILE="$XDG_STATE_HOME"/rnd

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR"/gnupg/S.gpg-agent.ssh
export DBUS_SESSION_BUS_ADDRESS=unix:path="$XDG_RUNTIME_DIR"/bus
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
