#!/usr/bin/bash

# Install git if not available
git --version &>/dev/null || winget install --id Git.Git -e --source winget
git "$@"
