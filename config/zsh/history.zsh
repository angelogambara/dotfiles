# ==============================
# History Options
# ==============================

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"  # persistent history file (xdg-compliant)
HISTSIZE=1000000                                              # number of history entries in memory
SAVEHIST=1000000                                              # number of history entries saved to file
mkdir -p "${HISTFILE%/*}"                                     # ensure parent directory exists

setopt append_history       # append instead of overwrite history file
setopt inc_append_history   # write to history as soon as commands are entered
setopt share_history        # share history across multiple running shells
setopt hist_ignore_all_dups # ignore duplicate commands
setopt hist_reduce_blanks   # trim leading and trailing spaces before saving
setopt extended_history     # include timestamps in history
