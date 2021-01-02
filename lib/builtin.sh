#!/usr/bin/env bash

function pushd { builtin pushd "$1" > /dev/null || return; }
function popd { builtin popd || exit > /dev/null; }

function force { [[ $HOOKA_FORCE == 1 ]]; }
function edit { $EDITOR "$@"; }
function empty { [[ -z $(tr -d '\n' < <(sed '/^#/d' "$1")) ]]; }


function git_version {  git --version | sed -e 's/^git version //'; }
function git_version_lt { version_lt "$(git_version)" "$1"; }
