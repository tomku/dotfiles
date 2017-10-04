# This file is bash-compatible, so that it can be linked to
# ~/.bash_profile and read by various things.

export EDITOR="vim"
export BROWSER="google-chrome"
export PAGER="less"
LESSOPT="-M"

# GOPATH and GOROOT
if [ -d "$HOME/src/go" ] ; then
    export GOPATH=$HOME/src/go
    export GOROOT=$(go env GOROOT)
    PATH=$HOME/src/go/bin:$PATH
fi

# rust/cargo
if [ -d $HOME/.cargo/bin ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# Haskell bins installed by cabal
if [ -d "$HOME/.cabal/bin" ] ; then
    PATH=$HOME/.cabal/bin:$PATH
fi

# Perl's local::lib
if [ perl -mlocal::lib=$HOME/.perl -e 1 2>/dev/null ] ; then
    eval $(PERL_LOCAL_LIB_ROOT= perl -mlocal::lib=$HOME/.perl)
fi

# Node.js packages installed in my home directory
if type -p npm >/dev/null 2>&1 ; then
    if [ ! -d "$HOME/.node/bin" ] ; then
        mkdir -p ~/.node/bin
        npm config set prefix ~/.node
    fi
    PATH=$HOME/.node/bin:$PATH
fi

# R packages installed in my home directory
if type -p R >/dev/null; then
    if [ ! -d "$HOME/.R" ] ; then
        mkdir ~/.R
    fi
    export R_LIBS_USER=$HOME/.R
fi

# Thanks for not reliably setting this, Ubuntu openjdk packages!
if [ -f /etc/alternatives/java ] ; then
    export JAVA_HOME=$(readlink -f /etc/alternatives/java | sed "s/\/jre.*//")
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

# rbenv
type -p rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"
if [ -d "$HOME/.rbenv/bin" ] ; then
    export PATH="$HOME/.rbenv/bin:$PATH"
fi

# phpenv
type -p phpenv >/dev/null && 2>&1 eval "$(phpenv init -)"
if [ -d "$HOME/.phpenv/bin" ] ; then
    export PATH="$HOME/.phpenv/bin:$PATH"
fi

# pyenv
type -p pyenv >/dev/null && 2>&1 eval "$(pyenv init -)"
if [ -d "$HOME/.pyenv/bin" ] ; then
    export PATH="$HOME/.pyenv/bin:$PATH"
fi

# opam/ocaml
if [ -r "$HOME/.opam/opam-init/init.zsh" ] ; then
    source $HOME/.opam/opam-init/init.zsh
fi

# Homebrew completion for bash
if  [ -n "$BASH" ] && 
    [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion"
    echo "BASH"
fi

if [ -n "$PRIVACY" ] ; then
    unset HISTFILE
    unset SHARE_HISTORY
fi

# Done!
export PATH
