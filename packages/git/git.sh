#!/usr/bin/bash

git --version &>/dev/null || winget install --id Git.Git -e --source winget
git "$@"
