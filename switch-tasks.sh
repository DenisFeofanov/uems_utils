#!/bin/bash
# Fetches latest branches from remote and switches to them. Discards local changes on that branch

declare -A gref_branches=(
    ["front_personal"]="feat-invitation-page"
    ["front_auth"]="test2"
    ["server_auth"]="test2"
    ["server_file"]="test2"
    ["server_personal"]="test2"
    ["server_platform"]="feat-email-invite"
    ["server_trade"]="test2"
    ["server_socket"]="test2"
    ["server_queue"]="test2"
)

declare -A denis_branches=(
    ["front_personal"]="feat-bid-submission"
    ["front_auth"]="test2"
    ["server_auth"]="test2"
    ["server_file"]="test2"
    ["server_personal"]="test2"
    ["server_platform"]="test2"
    ["server_trade"]="test2"
    ["server_socket"]="test2"
    ["server_queue"]="test2"
)

# Validate and select configuration
case "$1" in
    "gref") declare -n selected_branches=gref_branches ;;
    "denis") declare -n selected_branches=denis_branches ;;
    *) 
        echo "Usage: $0 [gref|denis]"
        exit 1
        ;;
esac

cd ".."
for repo in "${!selected_branches[@]}"; do
  if [ -d "$repo" ]; then
    echo "Switching $repo to ${selected_branches[$repo]}"
    (cd "$repo" && {
      # Fetch all remote branches
      git fetch origin || { echo "Failed to fetch $repo"; exit 1; }
      
      #  Create/switch to branch
      git checkout -B "${selected_branches[$repo]}" "origin/${selected_branches[$repo]}" || { 
        echo "Failed to switch $repo to ${selected_branches[$repo]}"
        exit 1
      }
    })
    echo ""  
  else
    ls 
    echo "Directory $repo not found - aborting script"
    exit 1
  fi
done