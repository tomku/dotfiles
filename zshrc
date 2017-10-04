#!/usr/bin/env zsh

DOTFILES=$(dirname $(readlink -- ~/.zshrc))
export DOTFILES

source $DOTFILES/shellrc

for script in $DOTFILES/zsh/*.zsh
do
    source "$script"
done
