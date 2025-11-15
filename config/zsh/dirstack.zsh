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
        if [[ -z "$ALACRITTY_WORKDIR_SET" ]]; then            # unless working directory is set:
            builtin cd -q -- "${tmpstack[1]}"                 # go to last directory
            dirstack=("${tmpstack[@]:1}")                     # restore stack without current dir
        else                                                  # if it was unset:
            dirstack=("${tmpstack[@]}")                       # restore stack with current dir
        fi
    fi
fi

# load function to add custom hooks
autoload -Uz add-zsh-hook

# save stack whenever directory changes
chpwd_dirstack() {
    print -l -- "$PWD" "${(u)dirstack[@]}" >| "$DIRSTACKFILE" # (u) = unique entries
}

# hook chpwd_dirstack to chpwd
add-zsh-hook -Uz chpwd chpwd_dirstack

setopt auto_pushd         # 'cd' pushes $OLDPWD onto stack
setopt pushd_ignore_dups  # remove duplicate entries
setopt pushd_minus        # use bash-style pushd numbering
