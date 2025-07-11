#!/usr/bin/bash

# Query registry for Git InstallPath and add it to PATH
add_git_to_path() {
    for key in \
        "HKCU\\Software\\GitForWindows" \
        "HKLM\\Software\\GitForWindows" \
        "HKLM\\Software\\WOW6432Node\\GitForWindows"
    do
        while IFS= read -r line; do
            if [[ "$line" == *"InstallPath"* ]]; then
                path="${line#*REG_SZ}"
                path="$(echo "$path" | sed 's/^[ \t]*//')"
                bin_path="${path}\\bin"
                if [[ -d "$bin_path" ]]; then
                    export PATH="$bin_path:$PATH"
                    return 0
                fi
            fi
        done < <(reg query "$key" /v InstallPath 2>nul)
    done
    return 1
}

add_git_to_path

# Run Git using updated PATH
exec git "$@"
