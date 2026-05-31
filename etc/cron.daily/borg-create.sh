#!/bin/sh

# Exit immediately if any command fails
set -e

# ==================
# 1. Configuration
# ==================

# Define the paths to backup
# 'set --' populates the positional parameters ($1, $2, etc.) used at the end of the script.
set -- / /boot /home

# Set default borg config directory
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/borg"

# Define the exclude file
EXCLUDE_FILE="$CONFIG_DIR/excludefile"

# Where to backup
REPO_DIR="/mnt/archive/BorgBackup"

# Name the backup
ARCHIVE_NAME="{hostname}@{now:%Y-%m-%d}"

# ==================
# 2. Interactivity
# ==================

# Check if the shell is running interactively
# If 'i' is present in the current shell options ($-), enable the verbose listing flag.
LIST_FLAG=""
case "$-" in
*i*) LIST_FLAG="--list" ;;
esac

# ==================
# 3. Pre-flight
# ==================

# Ensure the exclude file exists and is readable
if [ ! -r "$EXCLUDE_FILE" ]; then
  echo "Error: '$EXCLUDE_FILE': No read permission" >&2
  exit 1
fi

# Ensure the backup destination directory exists
if [ ! -d "$REPO_DIR" ]; then
  echo "Error: '$REPO_DIR': No such file or directory" >&2
  exit 1
fi

# ==================
# 4. Run Backup
# ==================

# Run the borg creation process
# - --one-file-system: Stay on the same filesystem (don't cross mount points like network drives)
# - "$@": Expands to the backup directories set in step 1 (/ /boot /home)
borg create \
  "$LIST_FLAG" \
  --exclude-from "$EXCLUDE_FILE" \
  --one-file-system \
  -- "$REPO_DIR::$ARCHIVE_NAME" "$@"
