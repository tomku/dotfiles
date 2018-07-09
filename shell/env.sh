#!/bin/sh
# This file is POSIX-compliant because it's shared between multiple shells.

export EDITOR="vim"
export BROWSER="google-chrome"
export PAGER="less"
export LESS="-M -R"

# GOPATH and GOROOT
if [ -d "$HOME/src/go" ] ; then
    export GOPATH=$HOME/src/go

    GOROOT=$(go env GOROOT)
    export GOROOT

    PATH=$HOME/src/go/bin:$PATH
fi

# rust/cargo
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# Haskell bins installed by cabal
if [ -d "$HOME/.cabal/bin" ] ; then
    PATH=$HOME/.cabal/bin:$PATH
fi

# R packages installed in my home directory
if command -v R >/dev/null; then
    if [ ! -d "$HOME/.R" ] ; then
        mkdir ~/.R
    fi
    export R_LIBS_USER=$HOME/.R
fi

# Thanks for not reliably setting this, Ubuntu openjdk packages!
if [ -f /etc/alternatives/java ] ; then
    JAVA_HOME=$(readlink -f /etc/alternatives/java | sed "s/\/jre.*//")
    export JAVA_HOME

    export JAVA_OPTS=-Djava.awt.headless=true
fi

# User-specific scripts
if [ -d "$HOME/bin" ] ; then
   PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Locally-installed man pages
if [ -d "$HOME/.local/share/man" ] ; then
    MANPATH="$HOME/.local/share/man:$(manpath -g)"
    export MANPATH
fi

# Version-managed language runtimes
for lang in rb nod py pl ; do
    if [ -d "$HOME/.${lang}env/bin" ] ; then
        export PATH="$HOME/.${lang}env/bin:$PATH"
    fi
    command -v ${lang}env >/dev/null 2>&1 && eval "$(${lang}env init -)"
done

# opam/ocaml
if [ -r "$HOME/.opam/opam-init/init.zsh" ] ; then
    # shellcheck source=/dev/null
    . $HOME/.opam/opam-init/init.zsh
fi

if [ -n "$PRIVACY" ] ; then
    unset HISTFILE
    unset SHARE_HISTORY
fi

export HAXE_STD_PATH="/usr/local/lib/haxe/std"

# Done!
export PATH
