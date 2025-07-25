#!/bin/sh
# This file is POSIX-compliant because it's shared between multiple shells.

export EDITOR="nvim"
#export BROWSER="firefox"
export PAGER="less"
export LESS="-M -R"
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export CLICOLORS=true

if [ -f "$DOTFILES/shell/local.sh" ]; then
    . "$DOTFILES/shell/local.sh"
fi

if [ -n "$PRIVACY" ]; then
    unset HISTFILE
    unset SHARE_HISTORY
fi

# MacOS system paths
if [ -x /usr/libexec/path_helper ]; then
    eval "$(/usr/libexec/path_helper -s)"
fi

# Homebrew
if [ -d "/opt/homebrew/bin" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# conda
if [ -d "$HOME/miniconda3" ]; then
    # These are currently identical, but better safe than sorry.
    if [[ -n "$ZSH_VERSION" ]]; then
        eval "$(~/miniconda3/bin/conda shell.zsh hook)"
    else
        eval "$(~/miniconda3/bin/conda shell.posix hook)"
    fi

    if ! grep -sq "auto_activate_base" ~/.condarc; then
        conda config --set auto_activate_base false
    fi
fi

if [ -f ~/.pythonrc ]; then
    export PYTHONSTARTUP=~/.pythonrc
fi

# Manually installed Zig
if [ -d "$HOME/.local/zig" ]; then
    PATH=$HOME/.local/zig:$PATH
fi

# GOPATH
if [ -d "$HOME/src/go" ]; then
    export GOPATH=$HOME/src/go
    PATH=$GOPATH/bin:$PATH
fi

# rust/cargo
if [ -d "$HOME/.cargo/bin" ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# ghcup
if [ -d "$HOME/.ghcup/bin" ]; then
    PATH="$HOME/.ghcup/bin:$PATH"
fi

# lean/elan/lake
if [ -d "$HOME/.elan/bin" ]; then
    PATH="$HOME/.elan/bin:$PATH"
fi

# ocaml/opam
if [ -d "$HOME/.opam" ]; then
    eval "$(opam env)"
fi

# julia/juliaup
if [ -d "$HOME/.juliaup/bin" ]; then
    PATH="$HOME/.juliaup/bin:$PATH"
fi

# Haxe
export HAXE_STD_PATH="/usr/local/lib/haxe/std"

# Dart/pub
if [ -d "$HOME/.pub-cache/bin" ]; then
    PATH="$HOME/.pub-cache/bin:$PATH"
fi

# moonbit
export PATH="$HOME/.moon/bin:$PATH"

# Flutter
if [ -d "$HOME/flutter/bin" ]; then
    PATH="$HOME/flutter/bin:$PATH"
fi

# Erlang/Elixir/mix/kerl/etc
unset KERL_BUILD_DOCS
export KERL_DOC_TARGETS="html chunks"

if [ -d "$HOME/.mix/escripts" ]; then
    PATH="$HOME/.mix/escripts:$PATH"
fi

# Doom Emacs
if [ -d "$HOME/.emacs.d/bin" ]; then
    PATH="$HOME/.emacs.d/bin:$PATH"
fi
# R packages installed in my home directory
if command -v R >/dev/null; then
    if [ ! -d "$HOME/.R" ]; then
        mkdir ~/.R
    fi
    export R_LIBS_USER=$HOME/.R
fi

# Thanks for not reliably setting this, Ubuntu openjdk packages!
if [ -f /etc/alternatives/java ]; then
    JAVA_HOME=$(readlink -f /etc/alternatives/javac | sed "s@/bin/javac@@")
    export JAVA_HOME

    export JAVA_OPTS=-Djava.awt.headless=true
fi

# User-specific scripts
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# mise
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate)"
fi

export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml

# Locally-installed man pages
if [ -d "$HOME/.local/share/man" ]; then
    MANPATH="$HOME/.local/share/man:$(manpath -q)"
    export MANPATH
fi

# Done!
export PATH
