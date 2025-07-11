#!/usr/bin/bash

# Function to query registry for Git install path
find_git_path() {
    local paths=(
        "HKLM\\SOFTWARE\\GitForWindows"
        "HKLM\\SOFTWARE\\WOW6432Node\\GitForWindows"
        "HKCU\\SOFTWARE\\GitForWindows"
    )

    for key in "${paths[@]}"; do
        path=$(reg query "$key" /v InstallPath 2>nul | awk -FREG_SZ '{print $2}' | sed 's/^[ \t]*//')
        if [[ -n "$path" && -x "$path\\bin\\git.exe" ]]; then
            echo "$path\\bin\\git.exe"
            return 0
        fi
    done
    return 1
}

# Try to find git in registry
git_path=$(find_git_path)

# If not found, install using winget
if [[ -z "$git_path" ]]; then
    echo "Git not found in registry. Installing..."
    winget install --id Git.Git -e --source winget
    # After install, try to find again
    git_path=$(find_git_path)
    if [[ -z "$git_path" ]]; then
        echo "Git installation failed or not detected."
        exit 1
    fi
fi

# Run git with passed arguments
"$git_path" "$@"
