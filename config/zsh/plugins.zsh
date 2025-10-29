# ==============================
# Plugins
# ==============================

# directory where plugins are cloned
ZNAP_REPOS_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/znap"
mkdir -p "$ZNAP_REPOS_DIR"

# clone znap itself if not already present
if [[ ! -r "$ZNAP_REPOS_DIR/znap/znap.zsh" ]]; then
  git clone --depth=1 https://github.com/marlonrichert/zsh-snap.git \
    "$ZNAP_REPOS_DIR/znap"
fi

# load plugin manager
source "$ZNAP_REPOS_DIR/znap/znap.zsh"

znap source MichaelAquilina/zsh-you-should-use
znap source jeffreytse/zsh-vi-mode
znap source ohmyzsh/ohmyzsh plugins/git
znap source ohmyzsh/ohmyzsh plugins/git-commit
znap source ohmyzsh/ohmyzsh plugins/git-extras
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-syntax-highlighting

# load each plugin in one go
for p in "$ZNAP_REPOS_DIR"/*/*/*.plugin.zsh; do
  source "$p"
done
