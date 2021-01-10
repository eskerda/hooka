#!/usr/bin/env bash

declare -A FMT_SET=(
  # Set
  [reset]=0
  [bold]=1
  [dim]=2
  [underline]=4
  [blink]=5
  [reverse]=7
  [hidden]=8
  # fg colors
  [fg:default]=39
  [fg:black]=30
  [fg:red]=31
  [fg:green]=32
  [fg:yellow]=33
  [fg:blue]=34
  [fg:magenta]=35
  [fg:cyan]=36
  [fg:light-gray]=37
  [fg:dark-gray]=90
  [fg:light-red]=91
  [fg:light-green]=92
  [fg:light-yellow]=93
  [fg:light-blue]=94
  [fg:light-magenta]=95
  [fg:light-cyan]=96
  [fg:white]=97
  # bg colors
  [bg:default]=49
  [bg:black]=40
  [bg:red]=41
  [bg:green]=42
  [bg:yellow]=43
  [bg:blue]=44
  [bg:magenta]=45
  [bg:cyan]=46
  [bg:light-gray]=47
  [bg:dark-gray]=100
  [bg:light-red]=101
  [bg:light-green]=102
  [bg:light-yellow]=103
  [bg:light-blue]=104
  [bg:light-magenta]=105
  [bg:light-cyan]=106
  [bg:white]=107
)

function vtfmt {
  local out=(); for comp in "$@"; do out+=("${FMT_SET[$comp]}"); done
  IFS=';' ; echo "\033[${out[*]}m"
}

_LOG_RESET_FMT=$(vtfmt reset)
_LOG_INFO_FMT="$(vtfmt bold fg:blue)"
_LOG_WARN_FMT="$(vtfmt bold fg:yellow)"
_LOG_ERR_FMT="$(vtfmt bold fg:red)"

function fmt_brackets {
  local color=$1; shift

  [[ $* =~ ^(\[.*\])(.*) ]] \
    && >&2 printf "$color%b$_LOG_RESET_FMT%b" "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" \
    || >&2 printf "%b" "$*"
}

function inf  { fmt_brackets "$_LOG_INFO_FMT" "$@" "\n"; }
function warn { fmt_brackets "$_LOG_WARN_FMT" "$@" "\n"; }
function err  { fmt_brackets "$_LOG_ERR_FMT"  "$@" "\n"; }
function err! { err "$@" && exit 1; }

function confirm {
  local ans=${2:-"y|Y"}
  [[ $HOOKA_FORCE == 1 ]] && return 0
  read -r -p "$(fmt_brackets "$_LOG_WARN_FMT" "$1 ($ans)? ")"
  [[ $REPLY =~ $ans ]]
}
