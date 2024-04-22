" Core vimrc file
" vim: tw=78 fdl=0 fdm=marker
"
" Intro. {{{1
"
" This file contains all of my non-GUI settings for vim. As is the nature of
" config files, many parts of this were cobbled together from various blog
" posts, Github repositories and digging around in the Vim docs. Most of the
" substantial functions (as well as many of the less obvious tweaks) came from
" Amir Salihefendic's vimrc, available at:
"
"   http://amix.dk/blog/post/19486#The-ultimate-vim-configuration-vimrc
"
" Many thanks to him for the well-commented examples.
"
" This file is now in maintenance mode, as I now use Visual Studio Code for
" most all but trivial edits. Much of the former functionality has been
" disabled to reduce vim's startup time and eliminate dependencies on
" scripting tools and plugins. The fully-featured version is available
" in Git history at https://github.com/tomku/dotfiles/blob/master/vimrc

" Clean initialization. {{{1
autocmd!
if &shell =~# 'fish$'
    set shell=bash
endif
let g:is_posix=1

set rtp+=$DOTFILES/vim

" Workaround for https://github.com/vim/vim/issues/3117

if has('python3')
    silent! python3 1
endif

" Load some sensible defaults from the example vimrc.
if filereadable('$VIM\_vimrc')
    source $VIM\_vimrc
elseif filereadable('$VIM/vimrc')
    source $VIM/vimrc
endif

" Normalize the home directory, since GVim on Windows can start up in some
" very useless places.
if (getcwd() == $VIMRUNTIME) || (getcwd() ==# 'C:\\WINDOWS\\system32')
    cd $HOME
endif

" Leader mappings. {{{1
" Need to set this early, because leader mappings use the value of <leader> at
" the time they're defined.
let g:mapleader = "\<Space>"
let g:maplocalleader = "\\"

set runtimepath+=~/.dotfiles/vim
" plug.vim initialization. {{{1
call plug#begin('~/.vim/plug')

" Plugins. {{{1

" Matchit.vim is included with vim.
runtime macros/matchit.vim

" Enable the Man command to view man pages.
runtime ftplugin/man.vim

" General support libraries. {{{2
Plug 'kana/vim-textobj-user'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-misc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'let-def/vimbufsync'

" Color scheme. {{{2
Plug 'altercation/vim-colors-solarized'

" Text objects. {{{2
Plug 'vim-scripts/argtextobj.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'paradigm/TextObjectify'
Plug 'reedes/vim-textobj-sentence'
Plug 'wellle/targets.vim'

" Basic editing additions. {{{2
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-rsi'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/YankRing.vim'
Plug 'justinmk/vim-sneak'
Plug 'chrisbra/NrrwRgn'
Plug 'jremmen/vim-ripgrep'

" General programming tools. {{{2
Plug 'losingkeys/vim-niji'
Plug 'docunext/closetag.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-eunuch'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'

" Language-specific tools. {{{2
Plug 'pearofducks/ansible-vim'
Plug 'vim-jp/vim-cpp'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'honza/dockerfile.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'dag/vim-fish'
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'tpope/vim-jdaddy'
Plug 'plasticboy/vim-markdown'
Plug 'othree/nginx-contrib-vim'
Plug 'spwhitt/vim-nix'
Plug 'StanAngeloff/php.vim'
Plug 'mitsuhiko/vim-python-combined'
Plug 'kurayama/systemd-vim-syntax'
Plug 'keith/tmux.vim'
Plug 'cespare/vim-toml'
Plug 'hashivim/vim-vagrant'
Plug 'stephpy/vim-yaml'
Plug 'tpope/vim-scriptease'

call plug#end()

" Basic settings. {{{1
syntax enable
filetype indent plugin on

" Make sure modelines are read, Debian turns this off by default.
set modeline

" Solarized looks fine on real consoles, but terrible in cmd.exe.
set t_Co=16
set background=dark
colorscheme default
highlight CursorLine ctermbg=0
highlight Folded ctermbg=0
highlight CursorLineNr ctermfg=7

" Default to UTF-8 and Unix line endings, but use the existing line endings
" if the file already has some.
set encoding=utf8
scriptencoding utf-8
set fileformats=unix,dos,mac
try
    lang en_US
catch
endtry

" Show partially-completed commands.
set showcmd

" Show a line highlighting where the cursor is.
set cursorline

" Enable hiding buffers without deleting them.
set hidden

" Allow backspacing over newlines, indentations.
set backspace=indent,eol,start

" Allow movement over newlines with the h and l keys.
set whichwrap+=h,l

" Use 4 space indentation, 8 spaces for existing tab characters, but never
" insert new tab characters.  Indentation commands should use shiftwidth and
" always round to the nearest 4 spaces.
set shiftwidth=4
set tabstop=8
set expandtab
set smarttab
set shiftround

" Preserve indentation when starting a new line.
set autoindent
set smartindent

" Tweak when comment characters are automatically inserted.
augroup formatoptions
    autocmd BufEnter * set formatoptions-=o
augroup END

" ...and deleted.
if (v:version > 703) || (v:version == 703 && has('patch541'))
  set formatoptions+=j " Delete comment character when joining commented lines
endif

" Show trailing/unnecessary whitespace
set list
set listchars=tab:→\ ,trail:·

" Enable completion for command line commands.
set wildmenu
set wildmode=list:longest

" Dictionary file for dictionary completion.
set dictionary=~/Dropbox/dotfiles/mobywords-combined.txt
set spellfile=~/Dropbox/dotfiles/spellfile.add

" Enable insert-mode completion.
set completeopt=menuone,longest,preview
set complete=.,w,b,u,t

" Enable fake word wrap, no actual wrapping is done to the file.
set linebreak
set wrap

" Enable relative line numbering, plus the current line number if vim is new
" enough to support it.
set relativenumber
set number

" Ignore case in regular expressions, unless they include upper case.
set ignorecase
set smartcase

" Enable incremental search and highlighting search matches.
set hlsearch
set incsearch
highlight Search ctermfg=0 ctermbg=3

" Flash matching braces/brackets.
set showmatch
set matchtime=2

" Keep three lines of context at the top/bottom of the screen at all times.
set scrolloff=3

" Keep five characters of context on the left/right of the screen at all
" times.
set sidescrolloff=5

" Show the last line, even if it's too long.
set display+=lastline

" Enable folding, but unfold everything by default.
set foldmethod=syntax
set foldlevelstart=99

" Set command line history to something saner than 20.
set history=1000

" Disable permanent backups, keep temporary backups during writes, disable
" swap files entirely.
set nobackup
set writebackup
set noswapfile

" Set up persistent undo. This is wrapped in a try/catch because it requires
" vim 7.3 or higher.
try
    set undodir=~/.vim/undo
    set undofile
catch
endtry

" Automatically read changed files if they're unchanged in Vim.
set autoread

" Automatically save changed files if we navigate away.
" Is this a good idea? Not sure yet, we'll see
set autowrite

" Set window titles, and disable the audible bell.
set title
set visualbell

" Use the X11 clipboard when available, unless we're on a Linux virtual
" terminal or inside GNU screen.
set clipboard=autoselect,exclude:cons\\\|linux\\\|screen

" Fix path issues from vim.wikia.com/wiki/Set_working_directory_to_the_current_file
let s:default_path = escape(&path, '\ ') " store default value of 'path'
" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
augroup pathfix
    autocmd BufRead *
        \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
        \ exec "set path-=".s:tempPath |
        \ exec "set path-=".s:default_path |
        \ exec "set path^=".s:tempPath |
        \ exec "set path^=".s:default_path
augroup END

" Disable IME by default.
set iminsert=0
set imsearch=-1
set noimcmdline

" Reuse open tabs and windows when switching buffers.
set switchbuf=usetab

" Create splits going towards the bottom right, not top left
set splitbelow
set splitright

" Mappings. {{{1
" Insert mode mappings. {{{2

" Normal mode mappings. {{{2
" Plugins.

" Managing tabs.
noremap <leader>tt :tabnew<cr>
noremap <leader>te :tabedit
noremap <leader>tc :tabclose<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>tn :tabnext<cr>
noremap <leader>tp :tabprevious<cr>
noremap <leader>tf :tabfirst<cr>
noremap <leader>tl :tablast<cr>
noremap <leader>tm :tabmove

nnoremap <silent> <leader><cr> :nohl<cr>

" Cleanly closing buffers
nnoremap <leader>x :Bdelete<cr>
" Quickfix and location list windows.
function! GetBufferList()
  redir =>l:buflist
  silent! ls
  redir END
  return l:buflist
endfunction

function! ToggleList(bufname, pfx)
  let l:buflist = GetBufferList()
  for l:bufnum in map(filter(split(l:buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(l:bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx ==# 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo 'Location List is Empty.'
      return
  endif
  exec(a:pfx.'open')
endfunction

nnoremap <silent> <leader>ol :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>oc :call ToggleList("Quickfix List", 'c')<CR>

" Quickfix and location list navigation.

nnoremap <leader>j :lnext<cr>
nnoremap <leader>k :lprevious<cr>

nnoremap <leader>J :cnext<cr>
nnoremap <leader>K :cprevious<cr>

" Quick toggles.
nnoremap cop :set paste!<cr>
nnoremap cof :call FoldColumnToggle()<cr>
nnoremap cob :call ToggleBackground()<cr>

function! ToggleBackground()
    if &background ==# 'light'
        set background='dark'
    else
        set background='light'
    endif
endfunction

function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=3
    endif
endfunction

" Disable search highlight and redraw screen.
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Always use very magic searches.
nnoremap / /\v
nnoremap ? ?\v

nnoremap <silent> p p`]

" Line transposition.
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z

" Trying these out...
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" Visual mode mappings. {{{2
" Visual line transposition.
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Add blank line before/after current line.
nnoremap [<space>  :put! =''<cr>
nnoremap ]<space>  :put =''<cr>

" Make indenting keep visual selection.
xnoremap <  <gv
xnoremap >  >gv

vnoremap <silent> y y`]
vnoremap <silent> p p`]

" Command line mode mappings. {{{2
" Command line snippets.
cnoremap $h edit ~/
cnoremap $d edit ~/Desktop/
cnoremap $j edit ./
cnoremap $c edit <C-\>eCurrentFileDir("edit")<cr>

function! CurrentFileDir(cmd)
  return a:cmd . ' ' . expand('%:p:h') . '/'
endfunction

" Heresy.
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Write to root-owned file via sudo tee.
cnoremap w!! %!sudo tee > /dev/null %

" Copy the current line into the command line prompt.
cnoremap <c-r><c-l> <c-r>=getline('.')<cr>

" Training wheels. {{{2
map <up> <nop>
map <down> <nop>
map <right> <nop>
map <left> <nop>

" Status line. {{{1
set laststatus=2
set cmdheight=1
set ruler

" Support functions for the status line. {{{2
function! CurDir()
    let l:curdir = substitute(getcwd(), $HOME, '~', 'g')
    return l:curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

" Automatic cleanup. {{{1
" Delete fugitive buffers when they aren't visible.
augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" Skeletons. {{{1
augroup skeleton
    autocmd!
    autocmd BufNewFile * :silent! execute ":0r " . expand('<sfile>:p:h') . "/templates/" . &ft
    autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END

" Plugin settings. {{{1
" YankRing plugin settings. {{{2
let g:yankring_history_dir = '~/.vim'

" vim-airline plugin settings. {{{2
let g:airline_powerline_fonts = 0
set noshowmode
let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'
let g:airline_section_y = '%{airline#util#wrap(airline#parts#ffenc(),0)}'

" vim-gitgutter plugin settings. {{{2
highlight! link GitGutterAdd DiffAdd
highlight! link GitGutterChange DiffChange
highlight! link GitGutterDelete DiffDelete
highlight! link SignColumn LineNr
if (v:version > 7.04) || (v:version == 704 && has('patch2201'))
    set signcolumn=yes
endif

" Language settings. {{{1
" C++ language settings. {{{2
augroup cpp
    autocmd!
    autocmd Filetype cpp compiler clang++
augroup END

" Fish scripting language settings. {{{2
augroup fish
    autocmd!
    autocmd FileType fish compiler fish
    autocmd FileType fish setlocal foldmethod=expr
augroup END

" HTML language settings. {{{2
let g:closetag_html_style=1

" Javascript language settings. {{{2
augroup javascript
    autocmd!
    autocmd FileType javascript setlocal foldenable
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
augroup END

" Mutt format settings. {{{2
" Set filetype to mail when editing emails for mutt.
augroup mutt
    autocmd!
    autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

" Python language settings. {{{2
augroup python
    autocmd!
    autocmd FileType python set nosmartindent
augroup END

" Ruby language settings. {{{2
augroup ruby
    autocmd!
    autocmd BufNewFile,BufReadPost *.rb setlocal foldmethod=indent nofoldenable
    autocmd BufNewFile,BufReadPost *.rb setlocal shiftwidth=2 expandtab
augroup END

" VimL language settings. {{{2
augroup viml
    autocmd FileType vim setlocal omnifunc=syntaxcomplete#Complete
augroup end

" Machine-specific settings. {{{1
if filereadable(glob('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" GUI settings. {{{1

set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=L

if has('gui_gtk')
    set guioptions-=m
endif
