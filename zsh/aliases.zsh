# No peeking!
if [ -s $DROPBOX/dotfiles/private/sh_aliases ] ; then
    . $DROPBOX/dotfiles/private/sh_aliases
fi

# For quick alias editing.
alias reload-aliases=". $DOTFILES/zsh/aliases.zsh"
alias edit-aliases="$EDITOR $DOTFILES/zsh/aliases.zsh"

# Create and enter a new directory in one quick command.
take() {
    mkdir -p $1
    cd $1
}

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

    # The following four git aliases were adapted from
    # http://pyrtsa.posterous.com/aligning-your-git-logs

    # Shows a nicely-formatted color git log with long commit messages
    # truncated for proper alignment.
    git config --global alias.l50 "!f () { git log --abbrev-commit --date=short --pretty=format:'%h%x00%cd%x00%s%x00%an%x00%d' \$@ | gawk --re-interval -F '\0' '{ printf \"\033[31m%s\033[0m \033[32m%s\033[0m  %-50s \033[30;1m%s\033[0m\033[33m%s\n\", \$1, \$2, gensub(/(.{49}).{2,}/, \"\\\\1…\",\"g\",\$3), \$4, \$5 }' | less -R; }; f"
    git config --global alias.l80 "!f () { git log --abbrev-commit --date=short --pretty=format:'%h%x00%cd%x00%s%x00%an%x00%d' \$@ | gawk --re-interval -F '\0' '{ printf \"\033[31m%s\033[0m \033[32m%s\033[0m  %-80s \033[30;1m%s\033[0m\033[33m%s\n\", \$1, \$2, gensub(/(.{79}).{2,}/, \"\\\\1…\",\"g\",\$3), \$4, \$5 }' | less -R; }; f"

    # Same as the two above, but with a colored branching graph on the
    # left side.
    git config --global alias.lg50 "!f () { git log --graph --color=always --abbrev-commit --date=relative --pretty=format:'%x00%h%x00%s%x00%cd%x00%an%x00%d' \$@ | gawk --re-interval -F '\0' '{ printf \"%s\033[31m%s\033[0m %-50s \033[32m%14s\033[0m \033[30;1m%s\033[0m\033[33m%s\n\", \$1, \$2, gensub(/(.{49}).{2,}/, \"\\\\1…\",\"g\",\$3), \$4, \$5, \$6 }' | less -R; }; f"
    git config --global alias.lg80 "!f () { git log --graph --color=always --abbrev-commit --date=relative --pretty=format:'%x00%h%x00%s%x00%cd%x00%an%x00%d' \$@ | gawk --re-interval -F '\0' '{ printf \"%s\033[31m%s\033[0m %-80s \033[32m%14s\033[0m \033[30;1m%s\033[0m\033[33m%s\\n\", \$1, \$2, gensub(/(.{79}).{2,}/, \"\\\\1…\",\"g\",\$3), \$4, \$5, \$6 }' | less -R; }; f"
}

git-find-origin() {
    git --git-dir=$1/.git remote show origin | grep "Fetch URL" | sed "s/  Fetch URL: //"
}

server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -mSimpleHTTPServer "${port}"
}

if where git >/dev/null && [ ! -f "$HOME/.gitconfig" ] ; then
    setup_git
fi

# Thanks to 'morsch' on Hacker News for this!
# Source: http://news.ycombinator.com/item?id=4285191
#
# Queries CommandLineFu and prints out all the matching one-liners
cmdfu(){ wget -qO - "http://www.commandlinefu.com/commands/matching/$@/$(echo -n "$@" | openssl base64)/plaintext"; }

alias checkhash='rhash --check-embedded'

update-repo() {
    if [ -d ".git" ]; then
        git pull -n
    elif [ -d ".hg" ]; then
        hg pull -u
    elif [ -d ".svn" ]; then
        svn up -q
    elif [ -d ".bzr" ]; then
        bzr pull
    elif [ -d "_darcs" ]; then
        darcs pull
    else
        echo ERROR... $PWD: No recognized version control repo found.
    fi
}

# TODO: Add error handling here to restore the starting directory
update-repos() {
    for x in $(ls); do
        echo "Updating $x"
        if [ -d "$x" ]; then 
            pushd -q $x
            update-repo
            popd -q
        fi
    done
}

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

alias conda-update='conda list | tail -n +3 | grep -v "\<pip\>" | cut -f 1 -d' ' | xargs conda update'
# This lists only the top-level installed npm packages.
npm-installed() {
    npm ls $1 --parseable | grep -v "node_modules.*node_modules" | sed "s|$(npm root $1)/||"
}

alias apt-upgrade='sudo apt-get update && sudo apt-get -V dist-upgrade'

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
