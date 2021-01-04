#!/usr/bin/env bash

function parse_version {
  [[ -z $1 ]] || [[ -z $2 ]] && >&2 echo "parse_version() requires two arguments" && exit 1

  local ver
  local subj=$1

  if [[ $subj =~ ^[^0-9]*(.*) ]]; then
    subj=${BASH_REMATCH[1]}

    local re='^(-rc[0-9]+$)?[.]?([0-9]+|[a-zA-Z]+)?(.*)$'

    while [[ $subj =~ $re ]]; do
      if [[ ${BASH_REMATCH[1]} != "" ]]; then
        ver="$ver.${BASH_REMATCH[1]}"
      fi

      if [[ ${BASH_REMATCH[2]} != "" ]]; then
        ver="$ver.${BASH_REMATCH[2]}"
      fi

      subj="${BASH_REMATCH[3]}"
      if [[ $subj == "" ]]; then
        break
      fi
    done

    ver="${ver:1}"

    IFS='.' read -r -a $2 <<< "$ver"
  fi
}

function version_eq {
  local version_a version_b

  parse_version $1 version_a
  parse_version $2 version_b

  # Note that we are indexing on the b components, ie: 1.11.100 == 1.11
  for index in "${!version_b[@]}"; do
    [[ "${version_a[index]}" != "${version_b[index]}" ]] && return 1
  done

  return 0
}

function version_lt {
  local version_a version_b

  parse_version $1 version_a
  parse_version $2 version_b

  for index in "${!version_a[@]}"; do
    if [[ ${version_a[index]} =~ ^[0-9]+$ ]]; then
      [[ "${version_a[index]}" -lt "${version_b[index]}" ]] && return 0
      [[ "${version_a[index]}" -gt "${version_b[index]}" ]] && return 1

    else
      [[ "${version_a[index]}" < "${version_b[index]}" ]] && return 0
      [[ "${version_a[index]}" > "${version_b[index]}" ]] && return 1
    fi
  done

  return 1
}

function version_gt {
  ! (version_eq $1 $2 || version_lt $1 $2)
}

function version_lte {
  (version_lt $1 $2 || version_eq $1 $2)
}

function version_gte {
  (version_gt $1 $2 || version_eq $1 $2)
}
