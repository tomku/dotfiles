#!/bin/sh
# This file is POSIX-compliant because it's shared between multiple shells.

export EDITOR="code"
export BROWSER="firefox"
export PAGER="less"
export LESS="-M -R"

# We load anaconda on-demand because it adds significant delay to startup.
anaconda() {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/tom/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/tom/opt/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/tom/opt/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/tom/opt/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
# <<< conda initialize <<<
}

# Homebrew on Linux
if [ -f /home/linuxbrew/.linuxbrew/bin/brew  ] ; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# MacOS system paths
if [ -x /usr/libexec/path_helper  ]; then
    eval "$(/usr/libexec/path_helper -s)"
fi

# GOPATH and GOROOT
if [ -d "$HOME/src/go" ] ; then
    export GOPATH=$HOME/src/go
    export GO111MODULE=on

    GOROOT=$(go env GOROOT)
    export GOROOT

    PATH=$HOME/src/go/bin:$PATH
fi

# Volta
if [ -d "$HOME/.volta/bin" ] ; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
fi

# rust/cargo
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
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

# Locally-installed man pages
if [ -d "$HOME/.local/share/man" ] ; then
    MANPATH="$HOME/.local/share/man:$(manpath -g)"
    export MANPATH
fi

if [ -n "$PRIVACY" ] ; then
    unset HISTFILE
    unset SHARE_HISTORY
fi

# Haxe
export HAXE_STD_PATH="/usr/local/lib/haxe/std"

# Krypton
export GPG_TTY=$(tty)

# Done!
export PATH
