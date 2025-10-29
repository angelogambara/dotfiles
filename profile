# ==============================
# Executables
# ==============================

prependpath() {
  case ":$PATH:" in
  *:"$1":*) ;;
  *) PATH="$1${PATH:+:$PATH}" ;;
  esac
}

export JAVA_HOME="/usr/lib/jvm/java-21-openjdk/bin"

for dir in "$HOME/git/dotfiles/local/bin" "$HOME/.local/bin" "$JAVA_HOME/bin"; do
  prependpath "$dir"
done

unset prependpath
export PATH

# ==============================
# XDG Base Directories
# ==============================

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/1000}"

# ==============================
# XDG Support: Session
# ==============================

export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

# ==============================
# Preferences
# ==============================

export QT_IM_MODULE="fcitx"
export GTK_THEME="Adwaita:dark"
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
