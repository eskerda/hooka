#!/usr/bin/env bash

function pushd { builtin pushd "$1" > /dev/null || return; }
function popd { builtin popd > /dev/null || exit; }

function force { [[ $HOOKA_FORCE == 1 ]]; }
function edit { $EDITOR "$@"; }
function empty { [[ -z $(tr -d '\n' < "$1") ]]; }
function empty_and_hash { [[ -z $(tr -d '\n' < <(sed '/^#/d' "$1")) ]]; }


function git_version {  git --version | sed -e 's/^git version //'; }
function git_version_lt { version_lt "$(git_version)" "$1"; }

function is_in { [[ " ${*:2:$#} " =~ [[:space:]]$1[[:space:]] ]]; }
