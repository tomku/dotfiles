# No peeking!
if [ -s $DROPBOX/dotfiles/private/sh_aliases ] ; then
    . $DROPBOX/dotfiles/private/sh_aliases
fi

# For quick alias editing.
alias reload-aliases="source $DOTFILES/zsh/aliases.zsh"
alias edit-aliases="$EDITOR $DOTFILES/zsh/aliases.zsh"
alias pull-dotfiles="pushd -q $DOTFILES; git pull; popd -q"

# This prevents costly ipv6 lookups, which aren't needed on any of my systems.
function curl() {
    command curl -4 "$@"
}

# Short command for symmetric file encryption through gpg.
alias gpg-encrypt='gpg -se --default-recipient-self'

# Set up basic git info
function setup_git() {
    echo "Initializing git config..."
    git config --global user.name "$ME"
    git config --global user.email "$EMAIL"
    git config --global push.default simple
}

if whence -p git >/dev/null && [ ! -f "$HOME/.gitconfig" ] ; then
    setup_git
fi

git-find-origin() {
    git --git-dir=$1/.git remote show origin | grep "Fetch URL" | sed "s/  Fetch URL: //"
}

server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -mSimpleHTTPServer "${port}"
}

alias swap-underscores='rename '\''s/_/ /g'\'
alias swap-whitespace='rename '\''s/ /_/g'\'
alias checkhash='rhash --check-embedded'

alias ansible-setup='ansible all -c local -i "127.0.0.1," -m setup'
alias ansible-reload='ansible-playbook -c local -i "127.0.0.1,"'
ansible-role() {
    local int_user simulate keep
    while getopts ":u:vnmk" opt ; do
        case $opt in
          u)
            int_user=$OPTARG
            ;;
          v)
            int_user="vagrant"
            ;;
          m)
            int_user=$USER
            ;;
          n)
            simulate=1
            keep=1
            ;;
          k)
            keep=1
            ;;
          \?)
            echo "Invalid option: -$OPTARG."
            ;;
          :)
            echo "Required argument missing for -$OPTARG."
            ;;
        esac
    done

    shift $(expr $OPTIND - 1)
    if [ -f role.yml ] ; then
        echo "ERROR: role.yml already exists."
        return
    fi
    cat > role.yml <<EOF
---
- hosts: all
  sudo: true
  remote_user: root
  vars:
    - accepted_oracle_license: true
    - jdk_version: 8
EOF
    if [ -n "$int_user" ] ; then
        echo "    - interactive_user: $int_user" >> role.yml
    fi
    echo "  roles:" >> role.yml
    for role in $@; do
        echo "    - $role" >> role.yml
    done
    if [ -z "$simulate" ] ; then
        ansible-playbook -c local -K -i "127.0.0.1," role.yml
    fi
    if [ -z "$keep" ] ; then
        rm role.yml
    fi
}

# This is only useful for quickie REPLs, it can't be used as a runner
scala-repl() {
    local classpath jline scala_version
    jline=$(ls -1 ~/.ivy2/cache/jline/jline/jars/*.jar | tail -1)
    scala_version=$(grep "scalaVersion" ~/.sbt/0.13/global.sbt | sed 's/.* := "\([0-9.]\+\)"/\1/')
    classpath="."
    for lib in "scala-compiler" "scala-library" "scala-reflect"; do
        classpath=$classpath:$HOME/.ivy2/cache/org.scala-lang/$lib/jars/$lib-$scala_version.jar
    done
    classpath=$classpath:$jline
    java -cp $classpath scala.tools.nsc.MainGenericRunner -cp $classpath $@
}

if [ -d /anaconda ] ; then
    alias ana='export PATH="/anaconda/bin:$PATH"'
fi
