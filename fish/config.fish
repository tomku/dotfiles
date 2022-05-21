# Environment

set -gx EDITOR "vim"
set -gx PAGER "less"
set -gx LESS "-M -R"
set -gx LSCOLORS "Gxfxcxdxbxegedabagacad"
set -gx CLICOLOR true

if test -r ~/.dircolors
    if command -v dircolors >/dev/null 2>&1
        dircolors -c ~/.dircolors | source
    else if command -v gdircolors >/dev/null 2>&1
        gdircolors -c ~/.dircolors | source
    end
end

if test -f ~/.config/fish/identity.fish
    source ~/.config/fish/identity.fish
end

function path_guard
    if string match -r "$argv" "$PATH" >/dev/null
        return
    end

    if test -d $argv
        set -gx PATH $argv $PATH
    end
end

alias rename_main="git branch -m master main && git branch --unset-upstream && git branch -u origin/main && git pull --ff-only"

if test -d /opt/homebrew/bin
    eval (/opt/homebrew/bin/brew shellenv)
end

if test -d $HOME/.asdf
    source $HOME/.asdf/asdf.fish
end

path_guard ~/.local/bin
path_guard /Users/tom/.mix/escripts
path_guard ~/.cargo/bin
path_guard $HOME/bin
path_guard $HOME/.local/bin
path_guard $HOME/.emacs.d/bin
path_guard $HOME/.ghcup/bin

if test -d ~/.volta
    set -gx VOLTA_HOME "$HOME/.volta"
    set -gx PATH "$VOLTA_HOME/bin" $PATH
end

if test -d "$HOME/src/go"
    set -gx GOPATH ~/src/go
    set -gx GO111MODULE on
    path_guard $GOPATH/bin
end

if test -d /Users/tom/miniconda3
    /Users/tom/miniconda3/bin/conda shell.fish hook | source
    conda config --set auto_activate_base false
end

if test -f /etc/alternatives/java
    set JAVA_HOME (readlink -f /etc/alternatives/javac | sed "s@/bin/javac@@")
end

if test -d "$HOME/.local/share/man"
    set -gx MANPATH "$HOME/.local/share/man" (manpath | tr ':' '\n')
end

set -gx GPG_TTY (tty)

if test -d ~/.opam
    eval (opam env)
end

if command -v starship  >/dev/null 2>&1
    starship init fish | source
else
    echo "Install Starship! https://starship.rs/"
end

set fish_color_command green
set fish_color_comment white

function setup_git
    echo "Initializing git config..."
    git config --global user.name "$ME"
    git config --global user.email "$EMAIL"
    git config --global push.default simple
    git config --global init.defaultBranch main
end

if command -v git >/dev/null 2>&1 && test ! -f "$HOME/.gitconfig"
    setup_git
end

# Aliases

alias swap-underscores 'rename '\''s/_/ /g'\'
alias swap-whitespace 'rename '\''s/ /_/g'\'
alias checkhash 'rhash --check-embedded'
alias mirror "rsync -avHLKx --progress --no-implied-dirs --delete --exclude 'lost+found' --exclude '.wh..*' --exclude '.Apple*'"

if command -v grm >/dev/null 2>&1
    alias rm="grm"
end

if command -v direnv >/dev/null 2>&1
    direnv hook fish | source
end

if test -f /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion
    source /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion
end

if test -d "$HOME/.nix-profile/bin"
    set -gx PATH "$HOME/.nix-profile/bin" $PATH
end

path_guard ~/flutter/bin
