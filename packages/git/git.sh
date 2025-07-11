#!/usr/bin/bash

# Query the registry for Git install path
get_git_path() {
    for key in \
        "HKCU\\Software\\GitForWindows" \
        "HKLM\\Software\\GitForWindows" \
        "HKLM\\Software\\WOW6432Node\\GitForWindows"
    do
        output=$(reg query "$key" /v InstallPath 2>nul)
        if [[ $? -eq 0 ]]; then
            git_path=$(echo "$output" | grep "InstallPath" | rev | cut -d' ' -f1 | rev)
            if [[ -n "$git_path" && -f "$git_path\\bin\\git.exe" ]]; then
                echo "$git_path\\bin\\git.exe"
                return 0
            fi
        fi
    done
    return 1
}

# Try to locate Git
git_path=$(get_git_path)

# Install if not found
if [[ -z "$git_path" ]]; then
    echo "Git not found in registry. Installing..."
    winget install --id Git.Git -e --source winget

    sleep 5
    git_path=$(get_git_path)
    if [[ -z "$git_path" ]]; then
        echo "Git still not found after installation."
        exit 1
    fi
fi

# Run git
"$git_path" "$@"
