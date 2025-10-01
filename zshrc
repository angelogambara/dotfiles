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
# Run-Help
# ==============================

autoload -Uz run-help-borg run-help-git run-help-sudo

autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

# ==============================
# Dirstack Plugin
# ==============================

autoload -Uz add-zsh-hook

DIRSTACKFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/dirs"
DIRSTACKSIZE='20'

mkdir -p "${DIRSTACKFILE%/*}"

if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
	dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
	[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
fi

chpwd_dirstack() {
	print -l -- "$PWD" "${(u)dirstack[@]}" >| "$DIRSTACKFILE"
}

add-zsh-hook -Uz chpwd chpwd_dirstack

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS PUSHD_MINUS

# ==============================
# Plugins
# ==============================

powerline-daemon -q
. /usr/share/powerline/bindings/zsh/powerline.zsh

. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==============================
# Terminal Title
# ==============================

autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m:%~\a'
	if [[ "$TERM" == 'screen'* ]]; then
    print -Pn -- '\e_\005{2}%n\005{-}@\005{5}%m\005{-} \005{+b 4}%~\005{-}\e\\'
  fi
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m:%~ %# ' && print -n -- "${(q)1}\a"
	if [[ "$TERM" == 'screen'* ]]; then
    print -Pn -- '\e_\005{2}%n\005{-}@\005{5}%m\005{-} \005{+b 4}%~\005{-} %# '
    print  -n -- "${(q)1}\e\\"
  fi
}

if [[ "$TERM" == (alacritty*|foot*|gnome*|konsole*|rxvt*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# ==============================
# Navigation
# ==============================

typeset -g -A key

# Create a zkbd compatible hash (man 5 terminfo).

key[Insert]="${terminfo[kich1]}"
key[Delete]="${terminfo[kdch1]}"

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"

key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"

key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[Up]="${terminfo[kcuu1]}"

key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

key[Backspace]="${terminfo[kbs]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# Assign a function to each key in our hash

[[ -n "${key[Insert]}" ]] && bindkey -- "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]] && bindkey -- "${key[Delete]}" delete-char

[[ -n "${key[Home]}" ]] && bindkey -- "${key[Home]}" beginning-of-line
[[ -n "${key[End]}" ]] && bindkey -- "${key[End]}" end-of-line

[[ -n "${key[PageUp]}" ]] && bindkey -- "${key[PageUp]}" beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]] && bindkey -- "${key[PageDown]}" end-of-buffer-or-history

[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-history
[[ -n "${key[Left]}" ]] && bindkey -- "${key[Left]}" backward-char
[[ -n "${key[Right]}" ]] && bindkey -- "${key[Right]}" forward-char
[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-history

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Check that the terminal is in application mode for $terminfo to be valid.

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# ==============================
# Reverse History Search
# ==============================

# Only the past commands matching the current line up to the current cursor
# position will be shown when Up or Down keys are pressed.

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# ==============================
# Aliases
# ==============================

konvert_to_png() {
  krita "$1" --export --export-filename "${1%.kra}".png
}
