# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a bash script utility for managing GitHub repository forks at scale. The repository contains a single executable script `fork-cleanup.sh` that provides operations for listing, renaming, and deleting GitHub repositories, with a focus on fork management.

## Architecture

- **fork-cleanup.sh**: Main executable bash script that wraps GitHub CLI (`gh`) commands
- Uses `jq` for JSON processing of GitHub API responses
- Interactive confirmation for destructive operations (deletion)
- Supports both individual repository operations and bulk operations via shell piping

## Key Components

### Main Script Functions
- `list-repos()`: Lists all repositories for a user/org
- `list-forks()`: Lists only forked repositories
- `delete-repo()`: Deletes a repository with confirmation
- `rename-repo()`: Renames a repository

### Environment Variables
- `OWNER`: GitHub username/org (defaults to authenticated user via `gh api user`)

## Dependencies

Required external tools:
- `gh` (GitHub CLI) - must be authenticated
- `jq` - for JSON processing

## Usage Commands

Test the script:
```bash
# Make executable if needed
chmod +x fork-cleanup.sh

# Test basic functionality
./fork-cleanup.sh list-repos
./fork-cleanup.sh list-forks
```

Validate script syntax:
```bash
bash -n fork-cleanup.sh
```

## Development Notes

- Script uses `set -euo pipefail` for strict error handling
- No formal test suite - validation is done through manual testing with GitHub API
- Repository operations are destructive - script includes confirmation prompts for safety