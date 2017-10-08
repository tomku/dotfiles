#!/usr/bin/env zsh

ZSH=$HOME/.oh-my-zsh
if [ -d $ZSH ] ; then
    SPACESHIP_PROMPT_ADD_NEWLINE=false
    SPACESHIP_PROMPT_SEPARATE_LINE=false
    SPACESHIP_TIME_SHOW=true
    SPACESHIP_PROMPT_SYMBOL="$"

    SPACESHIP_PROMPT_ORDER=(
        user          # Username section
        host          # Hostname section
        dir           # Current directory section
        git           # Git section (git_branch + git_status)
        hg            # Mercurial section (hg_branch  + hg_status)
        node          # Node.js section
        venv          # virtualenv section
        conda         # conda virtualenv section
        pyenv         # Pyenv section
        exec_time     # Execution time
        line_sep      # Line break
        battery       # Battery level and status
        time          # Time stampts section
        jobs          # Backgound jobs indicator
        exit_code     # Exit code section
        char          # Prompt character
    )
    ZSH_THEME="spaceship"

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
