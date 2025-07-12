#!/bin/bash

winget install --id Git.Git -e --source winget

echo "Adding alias to current session"
alias git='source /usr/bin/git' # For the current session
if ! grep -q "alias git='source /usr/bin/git'" ~/.bashrc; then
    echo "Adding alias to .bashrc"
    echo "alias git='source /usr/bin/git'" >> ~/.bashrc # For all future sessions
fi
