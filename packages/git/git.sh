#!/usr/bin/bash

# Extract PATH_OLD value from `export` output
path_old=$(export | grep '^declare -x PATH_OLD=' | sed -E 's/^declare -x PATH_OLD="(.*)"$/\1/')

# Replace colons and semicolons with newlines, then check each path
echo "$path_old" | tr ':;' '\n' | while read -r dir; do
  if [[ -x "$dir/git.exe" ]]; then
    echo "$dir/git.exe"
    break
  fi
done
