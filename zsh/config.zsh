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

# From http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Heavily modified from http://superuser.com/questions/497715/keep-tmux-title-from-fg-to-original-jobname
fix_fg_title() {
    local fg_title
    local remove_parens="\(*\)"
    if [[ $* == fg* ]]; then
        # Numeric process ID like 'fg %1'
        if [[ $* == *%<->* ]]; then
            fg_title=($(jobs ${${(z)1}[2]}))
        # Plain 'fg'
        elif [[ $1 == "fg" ]]; then
            fg_title=($(jobs %%))
        # Named process like 'fg %vim' or 'fg vim'
        else
            local arg="${${(z)1}[2]}"
            arg=${arg/\%}
            fg_title=($(jobs | grep $arg))
        fi
        fg_title="$fg_title"
        local title=${fg_title/${~remove_parens}}
        title=${${(z)title}[4]}
        title "$title"
    else
        fg_title="$1 end"
        title ${${(z)fg_title}[1]}
    fi
}

preexec_functions+=(fix_fg_title)
