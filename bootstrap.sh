#!/bin/sh

DOTFILES=$(dirname "$0")

if [ ! -e ~/.zshrc ] ; then
    echo "Creating .zshrc..."
    ln -s "$DOTFILES/zshrc" ~/.zshrc
fi

if [ ! -e ~/.bash_profile ] ; then
    echo "Creating .bash_profile..."
    ln -s "$DOTFILES/shellrc" ~/.bash_profile
fi

if [ ! -e ~/.zprofile ] ; then
    echo "Creating .zprofile..."
    ln -s "$DOTFILES/shellrc" ~/.zprofile
fi

if [ ! -e ~/.vimrc ] ; then
    echo "Creating .vimrc..."
    ln -s "$DOTFILES/vimrc" ~/.vimrc
    mkdir -p ~/.vim/undo
fi

if [ ! -e ~/.gvimrc ] ; then
    echo "Creating .gvimrc..."
    ln -s "$DOTFILES/vimrc" ~/.vimrc
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
