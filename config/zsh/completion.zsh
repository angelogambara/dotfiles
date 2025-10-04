# ==============================
# Completion
# ==============================

zstyle :compinstall filename "$HOME/.zshrc" # where compinstall writes config
autoload -Uz compinit; compinit             # initialize completion infrastructure
_comp_options+=(globdots)                   # include dotfiles

setopt complete_in_word                     # complete in the middle of a word
setopt always_to_end                        # after completion, move cursor to end
setopt menu_complete auto_menu              # open menu on second tab
