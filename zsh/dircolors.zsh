#!/usr/bin/env zsh

if command -v dircolors >/dev/null 2>&1 ; then
    DIRCOLORS=dircolors
elif command -v gdircolors >/dev/null 2>&1 ; then
    DIRCOLORS=gdircolors
fi
test -r ~/.dircolors && eval "$($DIRCOLORS -b ~/.dircolors)" || eval "$($DIRCOLORS -b)"
