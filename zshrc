# ==============================
# Initialize ZSH
# ==============================

gsettings set org.gnome.desktop.interface  gtk-theme Adwaita
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark

for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/*.zsh; do
  source "$f"
done
