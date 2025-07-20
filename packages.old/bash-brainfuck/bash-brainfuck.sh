#!/usr/bin/bash

declare -ai cell
declare -ai loop_starts
source_file=$1
source=''
ptr=0
offset=0
max_cell=0
depth=0

readSource() {
  source=$(< $source_file)
  source=${source//[^\[\].,<>+-]/}
}

readChars() {
  len=${#source}
  for(( offset=0; offset < $len; offset++ )); do
    handleChar "${source:$offset:1}"
  done
}

handleChar() {
  char=$1

  case $char in
  \+)
    (( cell[ptr]++ ))
    if (( cell[ptr] > 255 )); then
      cell[$ptr]=0
    fi
    ;;
  -)
    (( cell[ptr]-- ))
    if (( cell[ptr] < 0 )); then
        cell[$ptr]=255
    fi
    ;;
  '>')
    (( ptr++ ))
    if (( ptr > max_cell )); then
      (( max_cell++ ))
      cell[$ptr]=0
    fi
    ;;
  '<')
    (( ptr-- )) ;;
  '[')
    if [[ ${cell[$ptr]} == 0 ]]; then
      findEndOfLoop
    else
      (( depth++ ))
      loop_start[$depth]=$offset
    fi
    ;;
  ']')
    if [[ ${cell[$ptr]} != 0 ]]; then
      offset=${loop_start[$depth]}
    else
      (( depth-- ))
    fi
    ;;
  ,)
    read -rn1 input
    cell[$ptr]=$(printf '%d' "'$input")
    ;;
  \.)
    printf \\$(printf '%03o' ${cell[$ptr]}) ;;
  esac
}

findEndOfLoop() {
  loop_level=0

  while (( offset++ )); do
    if [[ ${source:$offset:1} == '[' ]]; then
      (( loop_level++ ))
    elif [[ ${source:$offset:1} == ']' ]]; then
      if [[ $loop_level == 0 ]]; then
        break
      fi
      (( loop_level-- ))
    fi
  done
}

main() {
  readSource
  readChars
}

main
