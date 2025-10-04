# ==============================
# History Options
# ==============================

HISTORY_IGNORE="(cd*|ls*|history|pwd)"                        # exclude these from history
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"  # persistent history file (xdg-compliant)
HISTSIZE=1000000                                              # number of history entries in memory
SAVEHIST=1000000                                              # number of history entries saved to file
mkdir -p "${HISTFILE%/*}"                                     # ensure parent directory exists

[[ $- != *i* ]] && return   # stop parsing if shell is not interactive

setopt append_history       # append instead of overwrite history file
setopt inc_append_history   # write to history as soon as commands are entered
setopt share_history        # share history across multiple running shells
setopt hist_ignore_all_dups # ignore duplicate commands
setopt hist_ignore_space    # ignore commands starting with space (e.g. for secrets)
setopt hist_reduce_blanks   # trim leading and trailing spaces before saving
setopt extended_history     # include timestamps in history

# ==============================
# Completion
# ==============================

zstyle :compinstall filename "$HOME/.zshrc" # where compinstall writes config
autoload -Uz compinit; compinit             # initialize completion infrastructure
_comp_options+=(globdots)                   # include dotfiles

setopt complete_in_word                     # complete in the middle of a word
setopt always_to_end                        # after completion, move cursor to end
setopt menu_complete auto_menu              # open menu on second tab

# ==============================
# Dirstack Persistence
# ==============================

DIRSTACKFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/dirs" # where the directory stack is saved
DIRSTACKSIZE=20                                               # max number of dirs to remember
mkdir -p "${DIRSTACKFILE%/*}"                                 # ensure parent directory exists

# restore previous dirstack if available
if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then  # if new terminal is opened:
    tmpstack=("${(@f)"$(< "$DIRSTACKFILE")"}")                # read file into array
    if  [[ -d "${tmpstack[1]}" ]]; then                       # if directory still exists:
        builtin cd -q -- "${tmpstack[1]}"                     # go to last directory
        dirstack=("${tmpstack[@]:1}")                         # restore stack without current dir
    fi
fi

autoload -Uz add-zsh-hook

# save stack whenever directory changes
chpwd_dirstack() {
    print -l -- "$PWD" "${(u)dirstack[@]}" >| "$DIRSTACKFILE" # (u) = unique entries
}

add-zsh-hook -Uz chpwd chpwd_dirstack

setopt auto_pushd         # 'cd' pushes $OLDPWD onto stack
setopt pushd_ignore_dups  # remove duplicate entries
setopt pushd_minus        # use bash-style pushd numbering

# ==============================
# Key Bindings
# ==============================

typeset -g -A key     # create global associative array
local name tag widget # set a few local variables

# associate each key with the appropriate zle widget
for name tag widget in \
  Insert    kich1  overwrite-mode \
  Delete    kdch1     delete-char \
  Home      khome  beginning-of-line \
  End       kend         end-of-line \
  PageUp    kpp    beginning-of-buffer-or-history \
  PageDown  knp          end-of-buffer-or-history \
  Up        kcuu1    history-substring-search-up \
  Down      kcud1  history-substring-search-down \
  Left      kcub1  backward-char \
  Right     kcuf1   forward-char \
  Control-Left  kLFT5 backward-word \
  Control-Right kRIT5  forward-word \
  Shift-Tab kcbt   reverse-menu-complete
do
  key[$name]=${terminfo[$tag]}
  [[ -n ${key[$name]} ]] && bindkey -- "${key[$name]}" "$widget"
done

# force terminal in "application mode" when zle is active
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  zle_application_mode_start() { echoti smkx }
  zle_application_mode_stop() { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# ==============================
# Generic Options
# ==============================

# prompt
powerline-daemon -q
source /usr/share/powerline/bindings/zsh/powerline.zsh

# vi-mode
bindkey -v
bindkey -v '^?' backward-delete-char

# you-should-use
YSU_HARDCORE_MODE=true
YSU_IGNORED_ALIASES=(g gp ga)
YSU_MESSAGE_POSITION="after"
YSU_MODE=ALL

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

# ==============================
# Functions
# ==============================

# export krita documents
kra2png() {
  krita "$1" --export --export-filename "${1%.kra}".png
}

kra2png_for() {
  for  k in "$@"; do
    kra2png "$k"
  done
}
