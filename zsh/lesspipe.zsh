#!/usr/bin/env zsh

for pipecmd in "lesspipe" "lesspipe.sh" ; do
    which $pipecmd 2>&1 >/dev/null  && eval "$(SHELL=/bin/sh $pipecmd)"
    export LESS_ADVANCED_PREPROCESSOR=1
done

