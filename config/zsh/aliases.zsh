# ==============================
# Aliases
# ==============================

# package manager
alias pacdep='sudo pacman -D --asdeps'
alias pacexp='sudo pacman -D --asexplicit'
alias pacls="pacman -Qqentt"
alias paclsorphans='sudo pacman -Qdt'
alias pacrmorphans='sudo pacman -Rns $(pacman -Qtdq)'

# quickly edit configs
alias dirsedit="nvim \$DIRSTACKFILE"
alias histedit="nvim \$HISTFILE"
