ZSH=$HOME/.oh-my-zsh
if [ -d $ZSH ] ; then
    ZSH_THEME="risto"

    zstyle :omz:plugins:ssh-agent identities id_rsa git_key torrent
    plugins=(git cpanm bundler heroku rake ssh-agent)

    source $ZSH/oh-my-zsh.sh
fi

zstyle ':completion:*:*:*:*:*' menu no-select

setopt +o CDABLE_VARS
setopt +o AUTO_CD
setopt +o CLOBBER
setopt +o CORRECT
setopt +o CORRECT_ALL

setopt -o SHARE_HISTORY
setopt -o HIST_IGNORE_SPACE

for pipecmd in "lesspipe" "lesspipe.sh" ; do
    which $pipecmd 2>&1 >/dev/null  && eval "$(SHELL=/bin/sh $pipecmd)"
done

stty -ixon

if [ -x /usr/bin/dircolors ] || [ -x /bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -p --color=auto'
    alias dir='dir --color=auto'
    alias vdir='dir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [[ ${TERM} == "xterm" ]] ; then
    export TERM=xterm-256color
fi

