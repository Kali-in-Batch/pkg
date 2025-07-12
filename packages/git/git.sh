#!/usr/bin/bash

# Extract the raw string with escape sequences
raw=$(export | grep '^declare -x PATH_OLD=' | sed -E "s/^declare -x PATH_OLD=\$'(.*)'$/\1/")

# Interpret escape sequences (e.g. \n) using printf
decoded=$(printf "%b" "$raw")

# Split on ':' and ';' and search for git.exe
echo "$decoded" | tr ':;' '\n' | while read -r dir; do
  if [[ -x "$dir/git.exe" ]]; then
    echo "$dir/git.exe"
    break
  fi
done
