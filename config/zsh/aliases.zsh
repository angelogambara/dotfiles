# ==============================
# Aliases
# ==============================

# Arch Linux package manager aliases
alias pacls='pacman -Qqett'
alias paclsorphans='pacman -Qdt'
alias pacrmorphans='sudo pacman -Rns $(pacman -Qtdq)'

# Change directory aliases
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Permission aliases
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# List aliases
alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lha'

# Directory aliases
alias mkdir='mkdir -p'
alias rmdir='rmdir -p'

# Safety aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Readability aliases
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Interactive aliases
alias grep='grep --color=auto'
alias less='less -R'

# Grep aliases
alias f='find . | grep'
alias h='history | grep'
alias p='ps aux | grep'

# More aliases
alias dirs='dirs -v'
alias jobs='jobs -l'

# Dirstack aliases
alias ed='$EDITOR $DIRSTACKFILE'
alias rd='rm $DIRSTACKFILE'

# Histfile aliases
alias eh='$EDITOR $HISTFILE'
alias rh='rm $HISTFILE'

# Use bat insted of cat
if command -v bat >/dev/null; then
  alias cat='bat --paging=never'
fi

# Use eza insted of ls
if command -v eza >/dev/null; then
  alias ls='eza --icons=always'
fi

# Use trash insted of rm
if command -v trash >/dev/null; then
  alias rm='trash'
fi
