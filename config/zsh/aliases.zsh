# ------------------------------------------------------------------------------
# Zsh Aliases Configuration
# ------------------------------------------------------------------------------

# This file defines shell aliases, grouped by purpose.
# Keep aliases simple and predictable — prefer short, memorable names
# for frequently used commands.

# ------------------------------------------------------------------------------
# Navigation
# ------------------------------------------------------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'
alias md='mkdir -p'
alias rd='rmdir'

# ------------------------------------------------------------------------------
# Listing & File Operations
# ------------------------------------------------------------------------------

alias ll='ls -lh'            # long format, human-readable
alias la='ls -A'             # show all except . and ..
alias l='ls -CF'             # classify entries
alias lla='ls -lha'          # full long list, all files

alias catn='cat -n'          # cat with line numbers
alias less='less -R'         # preserve colors
alias grep='grep --color=auto'
alias f='find . -type f -iname'

alias dirsed='$EDITOR $DIRSTACKFILE'
alias dirsrm='rm -f $DIRSTACKFILE'
alias histed='$EDITOR $HISTFILE'
alias histrm='rm -f $HISTFILE'

# ------------------------------------------------------------------------------
# System & Process Management
# ------------------------------------------------------------------------------

alias df='df -h'             # human-readable disk usage
alias du='du -h -d 1'        # summarize folder sizes
alias free='free -m'
alias psx='ps aux | grep'
alias psg='ps aux | grep -v grep | grep'
alias topmem='ps aux --sort=-%mem | head'
alias topcpu='ps aux --sort=-%cpu | head'

# ------------------------------------------------------------------------------
# Git Essentials
# ------------------------------------------------------------------------------

alias g='git'
alias ga='git add'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gs='git status -sb'
alias gl='git log --oneline --graph --decorate'
alias gp='git push'
alias gpl='git pull --rebase'
alias gcl='git clone'

# ------------------------------------------------------------------------------
# Package Management
# ------------------------------------------------------------------------------

if command -v apt >/dev/null; then
  alias update='sudo apt update && sudo apt upgrade -y'
  alias install='sudo apt install'
  alias remove='sudo apt remove'
  alias cleanup='sudo apt autoremove -y && sudo apt autoclean'
fi

if command -v pacman >/dev/null; then
  alias pacls="pacman -Qqentt"
  alias paclsorphans='sudo pacman -Qdt'
  alias pacrmorphans='sudo pacman -Rns $(pacman -Qtdq)'
fi

# ------------------------------------------------------------------------------
# Safety Aliases (Interactive Overwrites)
# ------------------------------------------------------------------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# ------------------------------------------------------------------------------
# Miscellaneous Shortcuts
# ------------------------------------------------------------------------------

alias c='clear'
alias h='history'
alias j='jobs -l'
alias reload='source ~/.zshrc'
alias path='echo -e ${PATH//:/\\n}'
alias please='sudo $(fc -ln -1)'

# ------------------------------------------------------------------------------
# Networking
# ------------------------------------------------------------------------------

alias myip='curl -s https://ipinfo.io/ip'
alias ports='sudo lsof -i -P -n | grep LISTEN'
alias pingg='ping 8.8.8.8'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'

# ------------------------------------------------------------------------------
# Conditional Aliases
# ------------------------------------------------------------------------------

if command -v bat >/dev/null; then
  alias cat='bat --paging=never'
fi

if command -v eza >/dev/null; then
  alias ls='eza --icons'
  alias ll='eza -lh --icons'
  alias la='eza -A --icons'
fi

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

backup() {
  local ARCHIVE=/mnt/backup::$(date +'%Y%m%d')
  local PATHS=(/)

  if [ -z "$(pgrep qemu)" ]; then
    sudo borg create --list \
      --compression auto,zstd,6 \
      --one-file-system \
      "$ARCHIVE" "${PATHS[@]}"
  fi
}

kra2png() {
  for kra in "$@"; do
    krita "$kra" --export --export-filename "${kra%.kra}".png >/dev/null 2>&1
  done
}

swap() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <file1> <file2>" >&2
    return 1
  fi

  if [[ ! -e $1 ]]; then
    echo "'$1': No such file or directory" >&2
    return 1
  fi

  if [[ ! -e $2 ]]; then
    echo "'$2': No such file or directory" >&2
    return 1
  fi

  local tmp="${file1}.swap.$$"

  mv -- "$1" "$tmp" || return 1
  mv -- "$2" "$1" || { mv -- "$tmp" "$file1"; return 1; }
  mv -- "$tmp" "$2" || return 1
}
