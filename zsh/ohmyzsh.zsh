ZSH=$HOME/.oh-my-zsh
if [ -d $ZSH ] ; then
    ZSH_THEME="risto"

    zstyle :omz:plugins:ssh-agent identities id_ed25519
    plugins=(docker git mosh ssh-agent fancy-control-z)

    source $ZSH/oh-my-zsh.sh
fi
