#!/usr/bin/bash
#
# Standard functions.

# Lines below are copyrighted by Dylan Araps under the MIT license.

basename() {
    # Get the basename of a path.
    # Usage: basename "path"
    path="${1%/}"
    printf "%s\\n" "${path##*/}"
}

dirname() {
    # Get the dirname of a path.
    # Usage: dirname "path"
    printf "%s\\n" "${1%/*}/"
}

strip() {
    # Strip characters from a string.
    # Usage: strip "string" "chars to remove"
    printf "%s\\n" "${1//$2}"
}

rstrip() {
    # Strip characters from the end of a string.
    # Usage: rstrip "string" "chars to remove"
    printf "%s\\n" "${1%%$2}"
}

lstrip() {
    # Strip characters from the start of a string.
    # Usage: lstrip "string" "chars to remove"
    printf "%s\\n" "${1##$2}"
}

# shellcheck disable=SC2086,SC2048
trim() {
    set -f
    set -- $*
    printf "%s\\n" "$*"
    set +f
}

trim_quotes() {
    # Trim quotes from a string.
    # Usage: trim_quotes "string"
    trim="${1//\'}"
    printf "%s\\n" "${trim//\"}"
}

lower() {
    # Lowercase a string.
    # Usage: lower "string"
    printf "%s\\n" "${1,,}"
}

upper() {
    # Uppercase a string.
    # Usage: lower "string"
    printf "%s\\n" "${1^^}"
}

date() {
    # Output the date/time.
    # Usage: date "format"
    printf "%($1)T\\n"
}

cat() {
    # Output the contents of files.
    # Usage: cat "file" "file" "file"
    for file in "$@"; do
        printf "%s\\n" "$(<"$file")"
    done
}

head() {
    # Output n lines from the start of a file.
    # Usage: head "n" "file"
    mapfile -tn "$1" line < "${2:-/etc/os-release}"
    printf "%s\\n" "${line[@]}"
}

tail() {
    # Output n lines from the end of a file.
    # Usage: tail "n" "file"
    mapfile -tn 0 line < "${2:-/etc/os-release}"
    printf "%s\\n" "${line[@]: -$1}"
}

lines() {
    # Count the lines in a file.
    # Usage lines "file"
    mapfile -tn 0 lines < "$1"
    printf "%s\\n" "${#lines[@]}"
}

reverse_array() {
    # Reverse an array.
    # Usage: reverse_array "array"

    # extdebug reverses arguments for some reason.
    # We can use this to reverse an array.
    shopt -s extdebug
    f()(printf "%s " "${BASH_ARGV[@]}"); f "$@"
    shopt -u extdebug

    printf "\\n"
}

rgb_to_hex() {
    # Convert an rgb color to hex.
    # Usage: rgb_to_hex "r" "g" "b"
    printf "#%02x%02x%02x\\n" "$1" "$2" "$3"
}

hex_to_rgb() {
    # Convert a hex color to rgb.
    # Usage: hex_to_rgb "color"
    r="${1:1:2}"
    g="${1:3:2}"
    b="${1:5:6}"

    printf "%s %s %s\\n" "$((16#$r))" "$((16#$g))" "$((16#$b))"
}

uptime() {
    # Output the uptime in a pretty format.
    # Usage: uptime
    seconds="$(< /proc/uptime)"
    seconds="${seconds/.*}"

    days="$((seconds / 60 / 60 / 24)) days"
    hours="$((seconds / 60 / 60 % 24)) hours"
    mins="$((seconds / 60 % 60)) minutes"

    # Remove plural if < 2.
    ((${days/ *} == 1))  && days="${days/s}"
    ((${hours/ *} == 1)) && hours="${hours/s}"
    ((${mins/ *} == 1))  && mins="${mins/s}"

    # Hide empty fields.
    ((${days/ *} == 0))  && unset days
    ((${hours/ *} == 0)) && unset hours
    ((${mins/ *} == 0))  && unset mins

    uptime="${days:+$days, }${hours:+$hours, }${mins}"
    uptime="${uptime%', '}"

    printf "%s\\n" "up ${uptime:-${seconds} seconds}"
}

colors() {
    # Display the terminal palette.
    # Usage: colors
    for i in {0..15}; do
        ((i%8==0)) && printf "\\n"
        printf "%b" "\\e[48;05;${i}m  \\e[0m"
    done

    printf "\\n\\n"
}

# Lines below are copyrighted by benja2998 under the MIT license.

$1
