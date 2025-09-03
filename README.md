# fork-cleanup

## Purpose

Deleting or renaming GitHub repos using the GitHub web UI is (understandably)
slow and difficult.

If you have a large number of forks to delete, or some repos that you want to
rename, this script should make your life easier.

> [!CAUTION]
> This script will quickly and happily delete GitHub repos. Use with caution.

## Requirements

* [gh](https://cli.github.com/)
* [jq](https://jqlang.org/)

## Basic usage

```
# List all repos
./fork-cleanup.sh list-repos

# List all repos that are forks
./fork-cleanup.sh list-forks

# Rename a repo
./fork-cleanup.sh <repo> <new-name>

# Delete a repo
./fork-cleanup.sh rm <repo>
```

## Advanced usage

### Deleting multiple forks with grep and xargs

```
# Check the list carefully...
./fork-cleanup.sh list-forks | grep some_string | xargs -n1 echo "DRY RUN" ./fork-cleanup.sh rm

# Really do it
./fork-cleanup.sh list-forks | grep some_string | xargs -n1 ./fork-cleanup.sh rm
```

### Listing repos belonging to an org or a different user

```
OWNER=someowner ./fork-cleanup.sh list-repos
```
