#!/usr/bin/bash

export PATH="$PATH_OLD"

git "$@"

export PATH="$PATH_NEW"
