#!/bin/sh
# This file is POSIX-compliant because it's shared between multiple shells.

export EDITOR="vi"
export BROWSER="firefox"
export PAGER="less"
export LESS="-M -R"
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export CLICOLORS=true

if [ -f "$DOTFILES/shell/local.sh"  ] ; then
    . "$DOTFILES/shell/local.sh"
fi

# MacOS system paths
if [ -x /usr/libexec/path_helper  ]; then
    eval "$(/usr/libexec/path_helper -s)"
fi

# Homebrew
if [ -d "/opt/homebrew/bin" ] ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# asdf
if [ -d "$HOME/.asdf" ] ; then
    source $HOME/.asdf/asdf.sh
fi

# GOPATH and GOROOT
if [ -d "$HOME/src/go" ] ; then
    export GOPATH=$HOME/src/go
    export GO111MODULE=on

    if command -v go >/dev/null; then
        GOROOT=$(go env GOROOT)
        export GOROOT
    fi

    PATH=$HOME/src/go/bin:$PATH
fi

# rust/cargo
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# Dart/pub
if [ -d "$HOME/.pub-cache/bin" ] ; then
    PATH="$HOME/.pub-cache/bin:$PATH"
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
    JAVA_HOME=$(readlink -f /etc/alternatives/javac | sed "s@/bin/javac@@")
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

# Erlang/Elixir/mix/kerl/etc
export KERL_BUILD_DOCS="yes"
export KERL_DOC_TARGETS="man html pdf chunks"
export KERL_INSTALL_MANPAGES="yes"

if [ -d "$HOME/.mix/escripts" ] ; then
    PATH="$HOME/.mix/escripts:$PATH"
fi

# Doom Emacs
if [ -d "$HOME/.emacs.d/bin" ] ; then
    PATH="$HOME/.emacs.d/bin:$PATH"
fi

# ghcup
if [ -d "$HOME/.ghcup/bin" ] ; then
    PATH="$HOME/.ghcup/bin:$PATH"
fi

# Locally-installed man pages
if [ -d "$HOME/.local/share/man" ] ; then
    MANPATH="$HOME/.local/share/man:$(manpath -q)"
    export MANPATH
fi

if [ -n "$PRIVACY" ] ; then
    unset HISTFILE
    unset SHARE_HISTORY
fi

# ocaml/opam
if [ -d "$HOME/.opam" ] ; then
    eval "$(opam env)"
fi

# Haxe
export HAXE_STD_PATH="/usr/local/lib/haxe/std"

if [ -d "$HOME/flutter/bin" ] ; then
    PATH="$HOME/flutter/bin:$PATH"
fi

# Done!
export PATH
