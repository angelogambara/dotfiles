# ==============================
# Initialize ZSH
# ==============================

powerline-daemon -q
source /usr/share/powerline/bindings/zsh/powerline.zsh

for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/*.zsh; do
  source "$f"
done
