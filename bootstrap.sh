#!/bin/sh

export ME="Tom Kurth"
export EMAIL="tom@losthalo.org"

ABS_CODE="from __future__ import print_function;import os;import sys;path = os.path.abspath(sys.argv[1]);print(os.path.dirname(path))"
abs_dirname() {
    python -c "$ABS_CODE" "$1"
}

DOTFILES=$(abs_dirname "$0")

if [ ! -e ~/.zshrc ] ; then
    echo "Creating .zshrc..."
    cat <<EOF >~/.zshrc
if [ -f $DOTFILES/zsh/zshrc ] ; then
    export ME="$ME"
    export EMAIL="$EMAIL"
    export DOTFILES=$DOTFILES
    if [ -z "\$DROPBOX" -a -d ~/Dropbox ] ; then
        export DROPBOX=~/Dropbox
    fi
    source $DOTFILES/zsh/zshrc
fi
EOF
fi

if [ ! -e ~/.zshenv ] ; then
    echo "Creating .zshenv..."
    cat <<EOF >~/.zshenv
if [ -f $DOTFILES/zsh/zshenv ] ; then
    source $DOTFILES/zsh/zshenv
fi
EOF
fi

if [ ! -e ~/.bash_profile ] ; then
    echo "Creating .bash_profile..."
    cat <<EOF >~/.bash_profile
if [ -f $DOTFILES/zsh/zshenv ] ; then
    . $DOTFILES/zsh/zshenv
fi
EOF
fi

if [ ! -e ~/.vimrc ] ; then
    echo "Creating .vimrc..."
    cat <<EOF >~/.vimrc
set rtp+=$DOTFILES/vim
source $DOTFILES/vim/vimrc
EOF
    mkdir -p ~/.vim/undo
fi

if [ ! -e ~/.gvimrc ] ; then
    echo "Creating .gvimrc..."
    cat <<EOF >~/.gvimrc
source $DOTFILES/vim/gvimrc
EOF
fi

if [ ! -e ~/.vim/autoload/plug.vim ] ; then
    echo "Installing plug.vim..."
    mkdir -p ~/.vim/autoload
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -e ~/.dircolors ] ; then
    echo "Creating .dircolors..."
    ln -s "$DOTFILES/dircolors" ~/.dircolors
fi

if [ ! -e ~/.inputrc ] ; then
    echo "Creating .inputrc..."
    ln -s "$DOTFILES/inputrc" ~/.inputrc
fi

if [ ! -e ~/.psqlrc ] ; then
    echo "Creating .psqlrc..."
    ln -s "$DOTFILES/psqlrc" ~/.psqlrc
fi

if [ ! -e ~/.tmux.conf ] ; then
    echo "Creating .tmux.conf..."
    ln -s "$DOTFILES/tmux.conf" ~/.tmux.conf
fi

if [ ! -e ~/.spacemacs ] ; then
    echo "Creating .spacemacs..."
    ln -s "$DOTFILES/spacemacs.el" ~/.spacemacs
fi

if [ ! -d ~/.emacs.d ] ; then
    echo "Installing Spacemacs..."
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi
