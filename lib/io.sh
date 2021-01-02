#!/usr/bin/env bash

function confirm {
  local ans=${2:-"y|Y"}
  [[ $HOOKA_FORCE == 1 ]] && return 0
  read -r -p "$1 ($ans)? "
  [[ $REPLY =~ $ans ]]
}

function fancy_log {
  local color=$1; shift

  [[ $* =~ ^(\[.*\])(.*) ]] \
    && >&2 echo -e "$color${BASH_REMATCH[1]}\033[1;0m${BASH_REMATCH[2]}" \
    || >&2 echo -e "$*"
}

function warn {
  fancy_log "\033[1;33m" "$@"
}

function err {
  fancy_log "\033[1;31m" "$@"
  exit 1
}

function inf {
  fancy_log "\033[1;34m" "$@"
}
