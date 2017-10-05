#!/bin/sh
# This file is POSIX-compliant because it's shared between multiple shells.

# For quick alias editing.
alias reload_aliases='source $DOTFILES/zsh/aliases.zsh'
alias edit_aliases='$EDITOR $DOTFILES/zsh/aliases.zsh'
alias pull_dotfiles='pushd -q $DOTFILES; git pull; popd -q'

alias ls='ls -p --color=auto'
alias dir='dir --color=auto'
alias vdir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Short command for symmetric file encryption through gpg.
alias gpg-encrypt='gpg -se --default-recipient-self'

# Set up basic git info
setup_git() {
    echo "Initializing git config..."
    git config --global user.name "$ME"
    git config --global user.email "$EMAIL"
    git config --global push.default simple
}

if command -v git >/dev/null 2>&1 && [ ! -f "$HOME/.gitconfig" ] ; then
    setup_git
fi

server() (
    port="${1:-8000}"
    open "http://localhost:${port}/"
    python -mSimpleHTTPServer "${port}"
)

alias swap-underscores='rename '\''s/_/ /g'\'
alias swap-whitespace='rename '\''s/ /_/g'\'
alias checkhash='rhash --check-embedded'

# This is only useful for quickie REPLs, it can't be used as a runner
scala_repl() (
    jline=$(find ~/.ivy2/cache/jline/jline/jars -name '*.jar' | sort | tail -1)
    scala_version=$(grep "scalaVersion" ~/.sbt/0.13/global.sbt | sed 's/.* := "\([0-9.]\+\)"/\1/')
    classpath="."
    for lib in "scala-compiler" "scala-library" "scala-reflect"; do
        classpath=$classpath:$HOME/.ivy2/cache/org.scala-lang/$lib/jars/$lib-$scala_version.jar
    done
    classpath=$classpath:$jline
    java -cp "$classpath" scala.tools.nsc.MainGenericRunner -cp "$classpath" "$@"
)
