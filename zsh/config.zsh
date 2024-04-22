#!/usr/bin/env zsh

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

fpath+=~/.zfunc
fpath=("$DOTFILES/zsh/completion/src" $fpath)

setopt complete_in_word
setopt always_to_end
WORDCHARS=''

zstyle ':completion:*:*:*:*:*' menu no-select
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

unsetopt cdable_vars
unsetopt auto_cd
unsetopt clobber
unsetopt correct_all

setopt share_history
setopt hist_ignore_space
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups 
setopt hist_verify

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=10000

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

autoload -Uz compinit
compinit

export MAILCHECK=0

precmd() { echo -ne "\e]1;${PWD/$HOME/~}\a" }

unalias run-help
autoload run-help

eval "$(starship init zsh)"

stty -ixon
