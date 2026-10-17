#!/bin/zsh

# ########
# Title
# ########

# Borrowed straight from the Arch Wiki
autoload -Uz add-zsh-hook

# Title when idle
function xterm_title_precmd() {
  print -Pn -- '\e]2;%n@%m %~\a'
}

# Title when running
function xterm_title_preexec() {
  print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
}

# Allow optionally disable the title for setting manually (E.g.,
# dwm-namescratchpads)
if [ -z "$DISABLE_XTERM_TITLE" ]; then
  add-zsh-hook precmd  xterm_title_precmd
  add-zsh-hook preexec xterm_title_preexec
fi

# ########
# Tab
# ########

# Disable . and .. in completion so they are not in your way when tab shows
# only one file or directory
zstyle ':completion:*' special-dirs false

# Enable Tab+Shift
bindkey "${key_info[BackTab]}" reverse-menu-complete

# ########
# Magic
# ########

# Load function that auto-quotes your URLs when you paste
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-url-magic

# Enable it thx
autoload -Uz url-quote-magic
autoload -Uz bracketed-paste-url-magic

# ########
# Prompt
# ########

export STARSHIP_CONFIG=$ZDOTDIR/themes/hydro.toml

STARSHIP_CACHE=$XDG_CACHE_HOME/zsh/cached-eval/starship-init-zsh.zsh

math_expr=(${STARSHIP_CACHE}(Nmh-12))
if [[ ! -s "${STARSHIP_CACHE}" ]] || ((! ${#math_expr})); then
  mkdir -p "${STARSHIP_CACHE:h}"
  starship init zsh >|"$STARSHIP_CACHE"
fi

cached-eval() {
  # Rebuild via a temp file so a failed command doesn't poison the cache.
  if [[ -z $cachefile(#qNmh-20) ]]; then
    mkdir -p $cachefile:h
    if ! "$@" >| $cachefile.$$; then
      command rm -f $cachefile.$$
      return 1
    fi
    command mv -f $cachefile.$$ $cachefile
  fi

  [[ -n "$cachefile" ]] || return 0
  source $cachefile
}

source "$STARSHIP_CACHE"


