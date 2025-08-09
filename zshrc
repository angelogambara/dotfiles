# ==============================
# Variables And Options
# ==============================

HISTFILE=/dev/null
HISTSIZE=1000000
SAVEHIST=1000000

setopt autocd correct noclobber
setopt interactive_comments
setopt complete_in_word always_to_end

setopt append_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
unsetopt extended_history

# ==============================
# Vi Prompt
# ==============================

bindkey -v
bindkey -v '^?' backward-delete-char

zstyle ':completion:*' menu select
zmodload zsh/complist

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# ==============================
# Autocompletion
# ==============================

zstyle :compinstall filename '/home/angelo/.zshrc'

autoload -Uz compinit
compinit
_comp_options+=(globdots)

# ==============================
# Navigation
# ==============================

bindkey "${terminfo[kich1]}" overwrite-mode
bindkey "${terminfo[kdch1]}" delete-char

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

bindkey "${terminfo[kpp]}" beginning-of-buffer-or-history
bindkey "${terminfo[knp]}" end-of-buffer-or-history

autoload -Uz up-line-or-beginning-search 
autoload -Uz down-line-or-beginning-search

bindkey "${terminfo[kcbt]}"  reverse-menu-complete

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop  { echoti rmkx }

	autoload -Uz add-zle-hook-widget
	add-zle-hook-widget -Uz zle-line-init   zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

bindkey "${terminfo[kLFT5]}" backward-word
bindkey "${terminfo[kRIT5]}"  forward-word

# ==============================
# Plugins
# ==============================

powerline-daemon -q
. /usr/share/powerline/bindings/zsh/powerline.zsh

. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
