#!/usr/bin/bash

find_git_path() {
    local keys=(
        "HKLM\\SOFTWARE\\GitForWindows"
        "HKLM\\SOFTWARE\\WOW6432Node\\GitForWindows"
        "HKCU\\SOFTWARE\\GitForWindows"
    )

    for key in "${keys[@]}"; do
        # Capture InstallPath value
        install_path=$(reg query "$key" /v InstallPath 2>nul | tr -d '\r' | grep "InstallPath" | sed -E 's/.*REG_SZ[ \t]+//')
        if [[ -n "$install_path" ]]; then
            git_exe="$install_path\\bin\\git.exe"
            # Ensure the executable exists
            if [[ -f "$git_exe" ]]; then
                echo "$git_exe"
                return 0
            fi
        fi
    done

    return 1
}

git_path=$(find_git_path)

if [[ -z "$git_path" ]]; then
    echo "Git not found in registry. Installing..."
    winget install --id Git.Git -e --source winget

    # Wait a moment and try again
    sleep 5
    git_path=$(find_git_path)
    if [[ -z "$git_path" ]]; then
        echo "Git installation failed or still not found."
        exit 1
    fi
fi

# Run git with passed args
"$git_path" "$@"
