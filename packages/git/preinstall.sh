#!/bin/bash

winget install --id Git.Git -e --source winget
echo "Adding \"\"alias git='source /usr/bin/git'\"\" to .bashrc if not already there"

if ! grep -q "alias git='source /usr/bin/git'" ~/.bashrc; then
    echo "alias git='source /usr/bin/git'" >> ~/.bashrc
    source ~/.bashrc
fi
