#!/bin/sh

umask g-w,o-w
DOTFILES=$(dirname "$0")
DOTFILES=$(python -c "import os,sys; print(os.path.realpath(sys.argv[1]))" "$DOTFILES")
echo $DOTFILES; exit

if [ ! -e ~/.Xresources ] ; then
    echo "Creating .Xresources..."
    ln -s "$DOTFILES/Xresources" ~/.Xresources
fi

if [ ! -e ~/.zshrc ] ; then
    echo "Creating .zshrc..."
    ln -s "$DOTFILES/zshrc" ~/.zshrc
fi

if [ ! -e ~/.mkshrc ] ; then
    echo "Creating .mkshrc..."
    ln -s "$DOTFILES/mkshrc" ~/.mkshrc
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
    ln -s "$DOTFILES/gvimrc" ~/.gvimrc
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

if [ ! -e ~/.ghci  ] ; then
    echo "Creating .ghci..."
    ln -s "$DOTFILES/ghci" ~/.ghci
    chmod 0600 ~/.ghci
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

if [ ! -d ~/.oh-my-zsh ] ; then
    echo "Installing oh-my-zsh..."
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

ZSH_CUSTOM=~/.oh-my-zsh/custom

if [ ! -d $ZSH_CUSTOM/themes/agkozak ] ; then
    mkdir -p $ZSH_CUSTOM/themes
    git clone https://github.com/agkozak/agkozak-zsh-prompt $ZSH_CUSTOM/themes/agkozak
    ln -s -f $ZSH_CUSTOM/themes/agkozak/agkozak-zsh-prompt.plugin.zsh $ZSH_CUSTOM/themes/agkozak.zsh-theme
fi

if [ ! -d ~/.pyenv ] ; then
    echo "Installing pyenv and plugins..."
    git clone --depth 1 https://github.com/pyenv/pyenv ~/.pyenv
fi

if [ ! -d ~/.pyenv/plugins/pyenv-virtualenv ] ; then
    git clone --depth 1 https://github.com/pyenv/pyenv-virtualenv ~/.pyenv/plugins/pyenv-virtualenv
fi

if [ ! -d ~/.pyenv/plugins/pyenv-update ] ; then
    git clone --depth 1 https://github.com/pyenv/pyenv-update ~/.pyenv/plugins/pyenv-update
fi

if [ ! -d ~/.pyenv/plugins/pyenv-which-ext ] ; then
    git clone --depth 1 https://github.com/pyenv/pyenv-which-ext.git ~/.pyenv/plugins/pyenv-which-ext
fi

if [ ! -d ~/.pyenv/plugins/pyenv-pip-migrate ] ; then
    git clone --depth 1 https://github.com/pyenv/pyenv-pip-migrate.git ~/.pyenv/plugins/pyenv-pip-migrate
fi

if [ ! -d ~/.nodenv ] ; then
    echo "Installing nodenv and plugins..."
    git clone https://github.com/nodenv/nodenv.git ~/.nodenv
    mkdir -p ~/.nodenv/plugins
fi

if [ ! -d ~/.nodenv/plugins/nodenv-update ] ; then
    git clone https://github.com/nodenv/nodenv-update ~/.nodenv/plugins/nodenv-update
fi

if [ ! -d ~/.nodenv/plugins/node-build ] ; then
    git clone https://github.com/nodenv/node-build ~/.nodenv/plugins/node-build
fi

if [ ! -d ~/.nodenv/plugins/nodenv-npm-migrate ] ; then
    git clone https://github.com/nodenv/nodenv-npm-migrate ~/.nodenv/plugins/nodenv-npm-migrate
fi
