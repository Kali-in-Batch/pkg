#!/usr/bin/bash

# Install git if not available
git --version &>/dev/null || winget install --id Git.Git -e --source winget

# Function: get InstallPath from registry key
get_git_path_from_registry() {
    reg.exe query "$1" /v InstallPath 2>nul | grep InstallPath | awk -FREG_SZ '{print $2}' | sed 's/^[ \t]*//'
}

GIT_PATH=""
GIT_PATH=$(get_git_path_from_registry "HKLM\\Software\\GitForWindows") ||
GIT_PATH=$(get_git_path_from_registry "HKLM\\Software\\WOW6432Node\\GitForWindows") ||
GIT_PATH=$(get_git_path_from_registry "HKCU\\Software\\GitForWindows")

# Echo result
[ -n "$GIT_PATH" ] && echo "Git is installed at: $GIT_PATH" || echo "Git installation path not found in registry."

# Run git.exe from found path
[ -n "$GIT_PATH" ] && "\"$GIT_PATH\\cmd\\git.exe\"" "$@" || git "$@"
