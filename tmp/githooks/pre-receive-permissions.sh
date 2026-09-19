#!/usr/bin/env bash

# Patterns are evaluated as globs inside case
FRONTEND_EMAILS="alice@company.com|bob@company.com"
DATABASE_EMAILS="charlie@company.com|david@company.com"
PIPELINE_EMAILS="alice@company.com"

# Patterns are evaluated as globs inside case
FRONTEND_BRANCHES="feature/*|dev/frontend"
DATABASE_BRANCHES="feature/*|dev/database|dev/server"
PIPELINE_BRANCHES="feature/*|dev/pipeline"

# shellcheck disable=SC2034 # keep for reference
while read -r oldrev newrev refname; do
  # Skip branch deletions
  if [ "$newrev" = "0000000000000000000000000000000000000000" ]; then
    continue
  fi

  # Extract branch name from refspec (e.g. refs/heads/dev/frontend -> dev/frontend)
  BRANCH="${refname#refs/heads/}"

  # Extract the email of the committer from the incoming commit object
  PUSHER_EMAIL=$(git cat-file -p "$newrev" | sed -n 's/^committer .*<\([^>]*\)> .*/\1/p' | head -n 1)

  # shellcheck disable=SC2254 # shut up about unquoted globs
  case "$PUSHER_EMAIL" in
  $FRONTEND_EMAILS)
    # Frontend users can push to frontend branches
    case "$BRANCH" in
    $FRONTEND_BRANCHES)
      # Pass
      ;;
    *)
      echo >&2 "git: pre-receive hook: You are configured to push only to frontend branches"
      exit 1
      ;;
    esac
    ;;
  $DATABASE_EMAILS)
    # Database users can push to database branches
    case "$BRANCH" in
    $DATABASE_BRANCHES)
      # Pass
      ;;
    *)
      echo >&2 "git: pre-receive hook: You are configured to push only to database branches"
      exit 1
      ;;
    esac
    ;;
  $PIPELINE_EMAILS)
    # pipeline users can push to pipeline branches
    case "$BRANCH" in
    $PIPELINE_BRANCHES)
      # Pass
      ;;
    *)
      echo >&2 "git: pre-receive hook: You are configured to push only to pipeline branches"
      exit 1
      ;;
    esac
    ;;
  esac
done
