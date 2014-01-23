export EDITOR="vim"
export BROWSER="google-chrome"
export PAGER="less"
LESSOPT="-M"

# Sane starting point that includes sbin folders
unset PATH
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# Haskell bins installed by cabal
if [ -d "$HOME/.cabal/bin" ] ; then
    PATH=$HOME/.cabal/bin:$PATH
fi

# Perl's local::lib
if [ perl -mlocal::lib=$HOME/.perl -e 1 2>/dev/null ] ; then
    eval $(PERL_LOCAL_LIB_ROOT= perl -mlocal::lib=$HOME/.perl)
fi

# Node.js packages installed in my home directory
if which npm >/dev/null ; then
    if [ ! -d "$HOME/.node/bin" ] ; then
        mkdir -p ~/.node/bin
        npm config set prefix ~/.node
    fi
    PATH="$HOME/.node/bin:$PATH"
fi

# R packages installed in my home directory
if which R >/dev/null; then
    if [ ! -d "$HOME/.R" ] ; then
        mkdir ~/.R
    fi
    export R_LIBS_USER=$HOME/.R
fi

# Anaconda or a default VirtualEnv
if [ -d "$HOME/.python/bin" ] ; then
    export PATH="$HOME/.python/bin:$PATH"
fi

# GEM_HOME for system ruby
if which ruby >/dev/null; then
    SYSTEM_RUBY_VERSION=$(ruby --version | sed -r 's/ruby ([0-9.p]+) .*/\1/')
    if [ ! -d "$HOME/.rbenv/bin" ] ; then
        if [ ! -e $HOME/.ruby/$SYSTEM_RUBY_VERSION ] ; then
            mkdir -p $HOME/.ruby/$SYSTEM_RUBY_VERSION 
        fi
        export GEM_HOME=$HOME/.ruby/$SYSTEM_RUBY_VERSION
        export PATH=$GEM_HOME/bin:$PATH
    fi
fi

# Thanks for not reliably setting this, Ubuntu openjdk packages!
if [ -f /etc/alternatives/java ] ; then
    export JAVA_HOME=$(readlink -f /etc/alternatives/java | sed "s/\/jre.*//")
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
if [ -d "$HOME/.rbenv/bin" ] ; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# phpenv
if [ -d "$HOME/.phpenv/bin" ] ; then
    export PATH="$HOME/.phpenv/bin:$PATH"
    eval "$(phpenv init -)"
fi

if [ -r "$HOME/.opam/opam-init/init.zsh" ] ; then
    . $HOME/.opam/opam-init/init.zsh
fi

if [ -n "$PRIVACY" ] ; then
    unset HISTFILE
    unset SHARE_HISTORY
fi

# Done!
export PATH
