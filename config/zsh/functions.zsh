# ==============================
# Functions (by Chris Titus)
# ==============================

# Searches for text in all files in the current folder
search() {
  # -H causes filename to be printed
  # -I ignore binary files
  # -i case-insensitive
  # -n causes line number to be printed
  # -r recursive search
  grep -HIinr --color=always "$1" . | less -r
}

# Copy with progress bar
cpp() {
  set -e
  strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
    awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# Copy and go to the directory
cpg() {
  if [ -d "$2" ]; then
    cp "$1" "$2" && cd "$2"
  else
    cp "$1" "$2"
  fi
}

# Move and go to the directory
mvg() {
  if [ -d "$2" ]; then
    mv "$1" "$2" && cd "$2"
  else
    mv "$1" "$2"
  fi
}

# Create and go to the directory
mkdirg() {
  mkdir -p "$1"
  cd "$1"
}

# Goes up a specified number of directories (i.e., up 4)
up() {
  local d=""
  limit=$1
  for ((i = 1; i <= limit; i++)); do
    d=$d/..
  done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd "$d"
}

# Automatically do an ls after each cd
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && eza -l
  else
    builtin cd ~ && eza -l
  fi
}

# Returns the last 2 fields of the working directory
pwdtail() {
  pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

# Trim leading and trailing spaces (for scripts)
trim() {
  local var=$*
  var="${var#"${var%%[![:space:]]*}"}"
  var="${var%"${var##*[![:space:]]}"}"
  echo -n "$var"
}

# Export your artworks from the command line
krita_export() {
  if ! file "$1" | grep 'application/x-krita'; then
    echo "'$1': File mime-type does not match (Probably not a Krita file)" >&2
    return 1
  fi

  if pgrep krita; then
    echo "Error: Please, close Krita before running" >&2
    return 1
  fi

  krita \
    --export-filename "${1%.kra}".png \
    --export \
    -- "$1" >&- 2>&-
}

# Backup the system with borg
backup() {
  local ARCHIVE=/mnt/backup::$(date +'%Y%m%d')
  local PATHS=(/)

  if pgrep qemu; then
    echo "Error: Refusing to backup while QEMU is running" >&2
    return 1
  fi

  sudo borg create --list \
    --compression auto,zstd,6 \
    --one-file-system \
    "$ARCHIVE" "${PATHS[@]}"
}

# Rename two files in place (works also if one file does not exist)
swap() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: ${0##*/} <file1> <file2>" >&2
    return 1
  fi

  if [[ -e $1 && ! -w $1 ]]; then
    echo "'$1': No write access to file or directory" >&2
    return 1
  fi

  if [[ -e $2 && ! -w $2 ]]; then
    echo "'$2': No write access to file or directory" >&2
    return 1
  fi

  local tmp="$1.swap.$$"

  {
    mv -- "$1" "$tmp"
    mv -- "$2" "$1"
    mv -- "$tmp" "$2"
  } 2>&-

  return 0
}
