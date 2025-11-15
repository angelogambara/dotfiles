# ==============================
# Executables
# ==============================

prependpath() {
  case ":$PATH:" in
  *:"$1":*) ;;
  *) PATH="$1${PATH:+:$PATH}" ;;
  esac
}

export JAVA_HOME="/usr/lib/jvm/default/bin"

for dir in "$JAVA_HOME" \
  "/var/lib/flatpak/exports/bin" \
  "$HOME/.local/share/flatpak/exports/bin" \
  "$HOME/.cargo/bin" \
  "$HOME/.local/bin" \
  "$HOME/Documents/Repos/dotfiles/local/bin"; do
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
# XDG Support: Configs
# ==============================

export GOPATH="$XDG_DATA_HOME/go"

# ==============================
# Preferences
# ==============================

export QT_IM_MODULE="fcitx"
export GTK_THEME="Adwaita:dark"
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
