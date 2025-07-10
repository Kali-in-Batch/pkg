#!/usr/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing via winget..."
    winget install --id Git.Git -e --source winget
fi

git "$@"
