#!/bin/bash

winget install --id Git.Git -e --source winget

if ! grep -q "alias git='source /usr/bin/git'" ~/.bashrc; then
    echo "Adding alias to .bashrc"
    echo "alias git='source /usr/bin/git'" >> ~/.bashrc # For all future sessions
    echo "Please run 'source ~/.bashrc' before running git, otherwise it will not work properly!"
fi
