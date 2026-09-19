#!/usr/bin/env bash

# Patterns are evaluated as globs inside case
PROTECTED_PATTERNS="master|main|release-*|patch-*|dev|dev/*"

# Determine branch being pushed
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Inspect parent process command line
PPID_COMMAND=$(ps -ocommand= -p $PPID 2>/dev/null)

# shellcheck disable=SC2254 # keep unquoted and expand as glob
case "$BRANCH" in
$PROTECTED_PATTERNS)
  # Check for force push or delete flags in the command
  if echo "$PPID_COMMAND" | grep -qE '\-f|\-\-force|\-d|\-\-delete'; then
    echo >&2 "---------------------------------------------------------"
    echo >&2 "git: pre-push hook: Force-pushing or deleting is disabled on branch '$BRANCH'"
    echo >&2 "---------------------------------------------------------"
    exit 1
  fi
  ;;
*)
  # Other branches are allowed
  ;;
esac

# Check stdin for branch deletion refs passed by Git
z40="0000000000000000000000000000000000000000"

# shellcheck disable=SC2034 # keep for reference
while read -r local_ref local_oid remote_ref remote_oid; do
  # Extract remote branch name (e.g., refs/heads/dev/database -> dev/database)
  remote_branch="${remote_ref#refs/heads/}"

  # shellcheck disable=SC2254 # keep unquoted and expand as glob
  case "$remote_branch" in
  $PROTECTED_PATTERNS)
    # If local OID is all zeros, this is a deletion push
    if [ "$local_oid" = "$z40" ]; then
      echo >&2 "---------------------------------------------------------"
      echo >&2 "git: pre-push hook: Deleting remote branch '$remote_branch' is forbidden."
      echo >&2 "---------------------------------------------------------"
      exit 1
    fi
    ;;
  *)
    # Other branches are allowed
    ;;
  esac
done
