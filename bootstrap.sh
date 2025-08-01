#!/bin/sh

umask g-w,o-w
DOTFILES=$(dirname "$0")
DOTFILES=$(python3 -c "import os,sys; print(os.path.realpath(sys.argv[1]))" "$DOTFILES")

if [ ! -e ~/.Xresources ]; then
    echo "Creating .Xresources..."
    ln -s "$DOTFILES/Xresources" ~/.Xresources
fi

if [ ! -e ~/.zshrc ]; then
    echo "Creating .zshrc..."
    ln -s "$DOTFILES/zshrc" ~/.zshrc
fi

if [ ! -e ~/.bash_profile ]; then
    echo "Creating .bash_profile..."
    ln -s "$DOTFILES/shellrc" ~/.bash_profile
fi

if [ ! -e ~/.zprofile ]; then
    echo "Creating .zprofile..."
    ln -s "$DOTFILES/shellrc" ~/.zprofile
fi

if [ ! -e ~/.vimrc ]; then
    echo "Creating .vimrc..."
    ln -s "$DOTFILES/vimrc" ~/.vimrc
    mkdir -p ~/.vim/undo
fi

if [ ! -e ~/.gvimrc ]; then
    echo "Creating .gvimrc..."
    ln -s "$DOTFILES/gvimrc" ~/.gvimrc
fi

if [ ! -e ~/.vim/autoload/plug.vim ]; then
    echo "Installing plug.vim..."
    mkdir -p ~/.vim/autoload
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -e ~/.dircolors ]; then
    echo "Creating .dircolors..."
    ln -s "$DOTFILES/dircolors" ~/.dircolors
fi

if [ ! -e ~/.inputrc ]; then
    echo "Creating .inputrc..."
    ln -s "$DOTFILES/inputrc" ~/.inputrc
fi

if [ ! -e ~/.psqlrc ]; then
    echo "Creating .psqlrc..."
    ln -s "$DOTFILES/psqlrc" ~/.psqlrc
fi

if [ ! -e ~/.ghci ]; then
    echo "Creating .ghci..."
    ln -s "$DOTFILES/ghci" ~/.ghci
    chmod 0600 ~/.ghci
fi

if [ ! -e ~/.pythonrc ]; then
    echo "Creating .pythonrc..."
    ln -s "$DOTFILES/pythonrc.py" ~/.pythonrc
fi

if [ ! -e ~/.tmux.conf ]; then
    echo "Creating .tmux.conf..."
    ln -s "$DOTFILES/tmux.conf" ~/.tmux.conf
fi

if [ ! -e ~/.doom.d ]; then
    echo "Creating .doom.d..."
    ln -s "$DOTFILES/doom" ~/.doom.d
fi

if [ ! -d "$DOTFILES/zsh/completion/src" ]; then
    echo "Installing zsh completion..."
    git clone https://github.com/zsh-users/zsh-completions "$DOTFILES/zsh/completion/"
fi

if [ ! -e ~/.config/starship.toml ]; then
    echo "Creating starship.toml..."
    mkdir -p ~/.config
    ln -s "$DOTFILES/starship.toml" ~/.config/starship.toml
fi

if [ ! -e ~/.default-gems ]; then
    echo "Creating .default-gems..."
    ln -s "$DOTFILES/default-gems" ~/.default-gems
fi

if [ ! -e ~/.default-python-packages ]; then
    echo "Creating .default-python-packages..."
    ln -s "$DOTFILES/default-python-packages" ~/.default-python-packages
fi

if [ ! -e ~/.default-npm-packages ]; then
    echo "Creating .default-npm-packages..."
    ln -s "$DOTFILES/default-npm-packages" ~/.default-npm-packages
fi

if [ ! -e ~/.config/mise/config.toml ]; then
    echo "Creating mise config..."
    mkdir -p ~/.config/mise
    ln -s "$DOTFILES/mise/mise-config.toml" ~/.config/mise/config.toml
fi

if [ ! -e ~/.config/aquaproj-aqua/aqua.yaml ]; then
    echo "Creating aqua config..."
    mkdir -p ~/.config/aquaproj-aqua/
    ln -s "$DOTFILES/aqua.yaml" ~/.config/aquaproj-aqua/aqua.yaml
fi
