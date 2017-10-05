#!/usr/bin/env zsh

DOTFILES=$(dirname $(readlink -- ~/.zshrc))
export DOTFILES

for script in $DOTFILES/zsh/*.zsh
do
    source "$script"
done
