#!/usr/bin/bash

# Save PATH_OLD to file
export | grep -i "path_old" >/tmp/old.txt 2>&1

# Read the contents of old.txt
oldtxt=$(< /tmp/old.txt)

# Initialize variable to store found path
git_path=""

# Split by colon and loop
IFS=: read -ra dirs <<< "$oldtxt"
for dir in "${dirs[@]}"; do
	if [[ -x "$dir/git.exe" ]]; then
		git_path="$dir/git.exe"
		break
	fi
done

if [[ -n "$git_path" ]]; then
	"$git_path" "$@"
else
	echo "Git not found."
fi
