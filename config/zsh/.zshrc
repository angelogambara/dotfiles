# load every zsh module
[[ -r ~/.profile ]] && source ~/.profile
for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/*.zsh; do
  source "$f"
done
