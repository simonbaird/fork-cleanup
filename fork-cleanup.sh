#!/bin/bash
set -euo pipefail

CMD=${1-""}
REPO=${2:-""}
NEW_NAME=${3:-""}

OWNER="${OWNER:-"$(gh api user --jq .login)"}"

if [[ "$REPO" == */* ]]; then
  REPO="$REPO"
else
  REPO="$OWNER/$REPO"
fi

function list-repos() {
  local fork_flag_maybe="${1:-""}"
  gh repo list "$OWNER" $fork_flag_maybe --limit 1000 --json name,nameWithOwner |
    jq -r '.[].nameWithOwner' |
    sort
}

function list-forks() {
  list-repos --fork
}

function delete-repo() {
  if [ -z "$REPO" ]; then
    echo "Error: Repo not specified for deletion"
    exit 1
  fi

  echo "Are you sure you want to delete $REPO? (y/N)"
  read -r confirmation
  if [[ "$confirmation" =~ ^[Yy]$ ]]; then
    echo "Deleting $REPO..."
    gh repo delete "$REPO" --yes
    echo "Deleted $REPO"
  else
    echo "Deletion cancelled"
  fi
}

function rename-repo() {
  if [ -z "$REPO" ]; then
    echo "Error: Repo not specified for rename"
    exit 1
  fi

  if [ -z "$NEW_NAME" ]; then
    echo "Error: New name not specified for rename"
    exit 1
  fi

  echo "Renaming $REPO to $NEW_NAME..."
  gh repo rename "$NEW_NAME" --repo "$REPO"

  echo "Renamed $REPO to $NEW_NAME"
}

case "$CMD" in
  "rm")
    delete-repo
    ;;

  "rename")
    rename-repo
    ;;

  "list-forks")
    list-forks
    ;;

  "list-repos")
    list-repos
    ;;

  *)
    echo "Usage:"
    echo "  $0 list-repos"
    echo "  $0 list-forks"
    echo "  $0 rename <repo> <new-name>"
    echo "  $0 rm <repo>"
    ;;
esac
