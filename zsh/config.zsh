#!/usr/bin/env zsh

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  fpath=(/home/linuxbrew/.linuxbrew/share/zsh-completions $fpath)
fi

ZSH=$HOME/.oh-my-zsh
if [ -d $ZSH ] ; then
    # ZSH_THEME="jreese"
    # ZSH_THEME="dpoggi"
    # ZSH_THEME="lukerandall"
    # ZSH_THEME="maran"
    # ZSH_THEME="risto"
    # ZSH_THEME="steeef"
    ZSH_THEME="agkozak"

    zstyle :omz:plugins:ssh-agent identities id_ed25519
    plugins=(docker git mosh ssh-agent)

    source $ZSH/oh-my-zsh.sh
fi

zstyle ':completion:*:*:*:*:*' menu no-select

setopt +o CDABLE_VARS
setopt +o AUTO_CD
setopt +o CLOBBER
setopt +o CORRECT
setopt +o CORRECT_ALL

setopt -o SHARE_HISTORY
setopt -o HIST_IGNORE_SPACE

unalias history

stty -ixon
