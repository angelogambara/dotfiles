#!/usr/bin/env bash

# ==============================================================================
# SCRIPT: Git Post-Receive Automated Deployment Hook
# ==============================================================================
#
# DESCRIPTION:
#   Automates code deployment directly on a remote server upon a successful
#   `git push`. When the configured main branch is pushed, this script extracts
#   the updated source files into a target web/app directory and tags the commit
#   with a timestamped release name.
#
# WHEN TO USE THIS:
#   - Lightweight or solo projects (monolithic web apps, static sites, APIs).
#   - Simple single-server deployments (e.g., VPS on Hetzner, DigitalOcean, AWS EC2).
#   - Cost-sensitive or air-gapped environments where third-party CI/CD runners
#     (like GitHub Actions or GitLab CI) are unavailable or unnecessary.
#
# WHEN NOT TO USE THIS:
#   - Complex multi-server or containerized (Docker/Kubernetes) infrastructure.
#   - Apps requiring extensive build/test steps that would block `git push` execution.
#
# PREREQUISITES:
#   1. A bare Git repository set up on your remote server.
#   2. This file saved inside the bare repo as: `.git/hooks/post-receive`
#   3. Executable permissions granted: `chmod +x .git/hooks/post-receive`
#   4. Read/write permissions for the Git user on the target `$WORKING_TREE` directory.
#
# USAGE:
#   Local machine:
#     $ git push production main
#
# CONFIGURATION:
#   Set `WORKING_TREE` below to the absolute path of your live deployment directory.
# ==============================================================================

# Path where you deploy your app (e.g., /srv/gdrive-clone)
WORKING_TREE="/path/to/your/deployment/folder"

# Path to .git folder
GIT_DIR="$(git rev-parse --git-dir)"

# Branch to checkout production code from (master or main)
MAIN_BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")"

while read -r _ _ refname; do
   # Extract the branch name from the ref (e.g., refs/heads/main -> main)
   branch="${refname#refs/heads/}"

   if [ -n "$branch" ] && [ "$branch" = "$MAIN_BRANCH" ]; then
      echo "--> Deploying $MAIN_BRANCH to $WORKING_TREE..."

      git --work-tree="$WORKING_TREE" --git-dir="$GIT_DIR" checkout -f "$MAIN_BRANCH"

      NOW=$(date +"%Y%m%d-%H%M")
      git tag "release_$NOW" "$MAIN_BRANCH"

      echo "   /==============================="
      echo "   | DEPLOYMENT COMPLETED"
      echo "   | Target branch: $MAIN_BRANCH"
      echo "   | Target folder: $WORKING_TREE"
      echo "   | Tag name     : release_$NOW"
      echo "   \=============================="
   fi
done
