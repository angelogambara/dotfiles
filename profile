# ~/.profile

# User environment and startup programs.

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

PS1=$([ "$USER" = 'root' ] && echo '# ' || echo '$ ')
export PS1

prependpath() {
  case ":$PATH:" in
  *:"$1":*) ;;
  *)
    PATH="$1${PATH:+:$PATH}"
    ;;
  esac
}

export JAVA_HOME=/usr/lib/jvm/java-21-openjdk/bin

prependpath "$HOME/.local/bin"
prependpath "$HOME/git/angelogambara/dotfiles/local/bin"
prependpath "$JAVA_HOME/bin"
unset prependpath

export PATH

# Set default umask
umask 022

# Load profiles from ~/.profile.d
if [ -d ~/.profile.d/ ]; then
  for f in ~/.profile.d/*.sh; do
    [ -r "$f" ] && . "$f"
  done
  unset f
fi

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

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

export GTK_THEME=Adwaita:dark
export QT_IM_MODULE=fcitx
