#!/usr/bin/bash

IFS=: read -ra dirs <<< "$PATH_OLD"
for dir in "${dirs[@]}"; do
  if [[ -x "$dir/git.exe" ]]; then
    echo "$dir/git.exe"
    break
  fi
done
