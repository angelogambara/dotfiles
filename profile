# ~/.profile

# User environment and startup programs.

export PS1=$([ "$USER" = 'root' ] && echo '# ' || echo '$ ')

prependpath() {
  case ":$PATH:" in
  *:"$1":*) ;;
  *)
    PATH="$1${PATH:+:$PATH}"
    ;;
  esac
}

export JAVA_HOME=/usr/local/lib/intellij-idea/jbr

prependpath "$HOME/.local/bin"
prependpath "$HOME/dotfiles/local/bin"
prependpath "$JAVA_HOME/bin"
unset prependpath

export PATH

# Set default umask
umask 022

# Load profiles from /etc/profile.d
if [ -d ~/.profile.d/ ]; then
  for f in ~/.profile.d/*.sh; do
    [ -r "$f" ] && . "$f"
  done
  unset f
fi

export GTK_THEME=Adwaita:dark
export QT_IM_MODULE=fcitx

# Setting other environment variables
if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi
if [ -z "$XDG_STATE_HOME" ]; then
  export XDG_STATE_HOME="$HOME/.local/state"
fi
if [ -z "$XDG_RUNTIME_DIR" ]; then
  export XDG_RUNTIME_DIR='/run/user/1000'
fi

export DBUS_SESSION_BUS_ADDRESS=unix:path="$XDG_RUNTIME_DIR"/bus
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR"/gnupg/S.gpg-agent.ssh

export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
