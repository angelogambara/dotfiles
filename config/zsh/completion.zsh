# ------------------------------------------------------------------------------
# Zsh Completion Configuration
# ------------------------------------------------------------------------------

# Load and initialize the completion system
autoload -Uz compinit

# Rebuild the .zcompdump file if it’s older than the shell config
[[ -n ~/.zcompdump(#qN.mh+24) ]] && compinit -C || compinit

# Use modern completion system
zmodload -i zsh/complist

# ------------------------------------------------------------------------------
# Completion behavior
# ------------------------------------------------------------------------------

# Automatically list choices on ambiguous completion
setopt AUTO_LIST

# Automatically complete when unambiguous
setopt AUTO_MENU

# Complete the next match on double-tab (instead of listing again)
setopt MENU_COMPLETE

# Don’t insert a slash after completing directories if the next char is already /
setopt COMPLETE_IN_WORD

# Don’t beep on failed completion
setopt NO_BEEP

# Allow completion from the middle of words
setopt COMPLETE_IN_WORD

# ------------------------------------------------------------------------------
# Styles (using zstyle)
# ------------------------------------------------------------------------------

# Enable menu selection (arrow keys navigate the completion list)
zstyle ':completion:*' menu select

# Use case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Group matches by category (commands, options, etc.)
zstyle ':completion:*' group-name ''

# Pretty colors for completion listings
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# When completing options, display descriptions inline
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'

# Show a nice prefix for corrections
zstyle ':completion:*:corrections' format '%F{red}%d (errors: %e)%f'

# Don’t try to complete hostnames unless needed
zstyle ':completion:*:hosts' use-ip yes

# ------------------------------------------------------------------------------
# Special completions
# ------------------------------------------------------------------------------

# Completion for `sudo` — complete as if no sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# Ignore backup and temporary files during completion
zstyle ':completion:*:(rm|mv|cp):*' ignore-patterns '*~' '*.swp' '*.tmp'

# ------------------------------------------------------------------------------
# Performance tweaks
# ------------------------------------------------------------------------------

# Save compiled completion dump to speed up future loads
# (this happens automatically via compinit, but we ensure location)

if [[ ! -f ~/.zcompdump ]]; then
  compinit -d ~/.zcompdump
fi
