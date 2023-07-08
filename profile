export PATH=~/dotfiles/local/bin:"$PATH"
export PS1=$([ "$USER" = 'root' ] && echo '# ' || echo '$ ')

export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
