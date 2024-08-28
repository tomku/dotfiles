#!/usr/bin/env zsh
# This file is POSIX-compliant because it's shared between multiple shells.

# For quick alias editing.
alias reload_aliases='source $DOTFILES/zsh/aliases.zsh'
alias edit_aliases='$EDITOR $DOTFILES/zsh/aliases.zsh'
alias pull_dotfiles='(cd $DOTFILES; git pull)'

autoload -U zmv

autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --hyperlink --git --group-directories-first"
elif [[ "$OSTYPE" == (darwin|freebsd)* ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=tty'
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi

if command -v ubi >/dev/null 2>&1; then
    alias ubi="ubi -v -i ~/.local/bin"
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias nvs='nvim --headless "+Lazy! sync" +qa'

# Short command for symmetric file encryption through gpg.
alias gpg-encrypt='gpg -se --default-recipient-self'

# Set up basic git info
setup_git() {
    echo "Initializing git config..."
    git config --global user.name "$ME"
    git config --global user.email "$EMAIL"
    git config --global push.default simple
    git config --global init.defaultBranch main
}

if command -v git >/dev/null 2>&1 && [ ! -f "$HOME/.gitconfig" ] ; then
    setup_git
fi

alias git-open="git ls-remote --get-url | xargs open"
alias rename_main="git branch -m master main && git branch --unset-upstream && git branch -u origin/main && git pull --ff-only"

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

alias mirror="rsync -avHLKx --progress --no-implied-dirs --delete --exclude 'lost+found' --exclude '.wh..*' --exclude '.Apple*'"

if command -v grm >/dev/null 2>&1 ; then
    alias rm="grm"
fi

if command -v direnv >/dev/null 2>&1 ; then
    eval "$(direnv hook zsh)"
fi


rename_branch() {
    git branch -m $1 $2
    git branch --unset-upstream
    git branch -u origin/$2
    git remote set-head -a origin
    git pull --ff-only
}
