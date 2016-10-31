#!/bin/sh

export ME="Tom Kurth"
export EMAIL="tom@losthalo.org"
DOTFILES=$(dirname $(readlink -f $0))

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
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -e ~/.dircolors ] ; then
    echo "Creating .dircolors..."
    ln -s $DOTFILES/dircolors ~/.dircolors
fi

if [ ! -e ~/.inputrc ] ; then
    echo "Creating .inputrc..."
    ln -s $DOTFILES/inputrc ~/.inputrc
fi

if [ ! -e ~/.taskrc ] ; then
    echo "Creating .taskrc..."
    ln -s $DOTFILES/taskrc ~/.taskrc
fi

if [ ! -e ~/.tmux.conf ] ; then
    echo "Creating .tmux.conf..."
    ln -s $DOTFILES/tmux.conf ~/.tmux.conf
fi

if [ ! -d ~/.emacs.d ] ; then
    echo "Creating .emacs.d..."
    mkdir ~/.emacs.d
fi

if [ ! -e ~/.emacs.d/init.el ] ; then
    echo "Creating .emacs.d/init.el..."
    cat <<EOF >~/.emacs.d/init.el
(load-file "$DOTFILES/emacs/init.el")
EOF
fi
