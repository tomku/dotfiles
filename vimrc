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
" Clean initialization. {{{1
autocmd!
if &shell =~# 'fish$'
    set shell=bash
endif
let g:is_posix=1

set rtp+=$DOTFILES/vim

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
Plug 'mattn/webapi-vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-misc'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'let-def/vimbufsync'

" Color schemes. {{{2
Plug 'altercation/vim-colors-solarized'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-vividchalk'
Plug 'w0ng/vim-hybrid'
Plug 'reedes/vim-colors-pencil'
Plug 'zefei/cake16'
Plug 'mhartington/oceanic-next'
Plug 'jdkanani/vim-material-theme'
Plug 'dracula/vim'
Plug 'chriskempson/base16-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'jansenfuller/crayon'
Plug 'KeitaNakamura/neodark.vim'
Plug 'roosta/vim-srcery'
Plug 'rakr/vim-one'

" Text objects. {{{2
Plug 'argtextobj.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'paradigm/TextObjectify'
Plug 'reedes/vim-textobj-sentence'
Plug 'wellle/targets.vim'

" Basic editing additions. {{{2
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-rsi'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'simnalamburt/vim-mundo'
if v:version > 703
    Plug 'SirVer/ultisnips'
endif
Plug 'honza/vim-snippets'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'YankRing.vim'
Plug 'justinmk/vim-sneak'
Plug 'chrisbra/NrrwRgn'

" Prose writing. {{{2
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-litecorrect'
Plug 'reedes/vim-lexical'

" Navigation and window management. {{{2
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-session'
Plug 'ZoomWin'
Plug 'moll/vim-bbye'

" General programming tools. {{{2
Plug 'losingkeys/vim-niji'
Plug 'basepi/vim-conque'
Plug 'docunext/closetag.vim'
Plug 'dbext.vim'
" Powershell doesn't like this, and it probably doesn't work in cmd.exe.
if ( (has('win32') > 0) || (has('win64') > 0) ) && has('gui') == 0
    Plug 'krisajenkins/vim-pipe'
endif
Plug 'mattn/gist-vim'
Plug 'jgdavey/tslime.vim'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'
Plug 'tpope/vim-git'
Plug 'tpope/vim-projectionist'
Plug 'int3/vim-extradite'
Plug 'junegunn/vader.vim'
Plug 'tpope/vim-eunuch'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'

" Language-specific tools. {{{2
Plug 'pearofducks/ansible-vim'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-jp/vim-cpp'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-eastwood'
Plug 'venantius/vim-cljfmt'
Plug 'the-lambda-church/coquille'
Plug 'rhysd/vim-crystal'
Plug 'JulesWang/css.vim'
Plug 'honza/dockerfile.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'ElmCast/elm-vim'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-skeletons'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/erlang-motions.vim'
Plug 'dag/vim-fish'
Plug 'FStarLang/VimFStar', {'for': 'fstar'}
Plug 'tikhomirov/vim-glsl'
Plug 'fatih/vim-go'
Plug 'mustache/vim-mustache-handlebars'
Plug 'neovimhaskell/haskell-vim'
Plug 'bitc/lushtags'
Plug 'eagletmt/ghcmod-vim'
Plug 'bitc/vim-hdevtools'
Plug 'eagletmt/neco-ghc'
Plug 'Twinside/vim-hoogle'
Plug 'mpickering/hlint-refactor-vim'
Plug 'pbrisbin/vim-syntax-shakespeare'
Plug 'nbouscal/vim-stylish-haskell'
Plug 'yaymukund/vim-haxe'
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'
Plug 'idris-hackers/idris-vim'
Plug 'andreimaxim/vim-io'
Plug 'glanotte/vim-jasmine'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'tpope/vim-jdaddy'
Plug 'mxw/vim-jsx'
Plug 'JuliaLang/julia-vim'
Plug 'udalov/kotlin-vim'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-liquid'
Plug 'tbastos/vim-lua'
Plug 'sophacles/vim-bundle-mako'
Plug 'plasticboy/vim-markdown'
Plug 'othree/nginx-contrib-vim'
Plug 'zah/nim.vim'
Plug 'spwhitt/vim-nix'
Plug 'b4winckler/vim-objc'
Plug 'jrk/vim-ocaml'
Plug 'vim-scripts/octave.vim--'
Plug 'petRUShka/vim-opencl'
Plug 'elehack/vim-oz'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'exu/pgsql.vim'
Plug 'StanAngeloff/php.vim'
Plug 'PProvost/vim-ps1'
Plug 'adimit/prolog.vim'
Plug 'raichoo/purescript-vim'
Plug 'FrigoEU/psc-ide-vim'
Plug 'mitsuhiko/vim-python-combined'
Plug 'vim-scripts/R.vim'
Plug 'wlangstroth/vim-racket'
Plug 'jneen/ragel.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'reasonml-editor/vim-reason'
Plug 'sheerun/rspec.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'derekwyatt/vim-sbt'
Plug 'derekwyatt/vim-scala'
Plug 'ARM9/snes-syntax-vim'
Plug 'keith/swift.vim'
Plug 'kurayama/systemd-vim-syntax'
Plug 'timcharper/textile.vim'
Plug 'keith/tmux.vim'
Plug 'cespare/vim-toml'
Plug 'hashivim/vim-vagrant'
Plug 'HerringtonDarkholme/yats.vim'

if v:version > 703
    Plug 'Quramy/tsuquyomi'
endif

Plug 'stephpy/vim-yaml'
Plug 'tpope/vim-scriptease'
Plug 'c9s/vimomni.vim'

if !empty(glob('/Applications/factor/misc/vim'))
    let g:FactorRoot = '/Applications/factor'
    Plug '/Applications/factor/misc/vim'
endif

call plug#end()

" Basic settings. {{{1
syntax enable
filetype indent plugin on

" Make sure modelines are read, Debian turns this off by default.
set modeline

" Solarized looks fine on real consoles, but terrible in cmd.exe.
set t_Co=16
set background=dark
if ( (has('win32') > 0) || (has('win64') > 0) ) && has('gui') == 0
    colorscheme desert
    highlight CursorLine ctermbg=7
    highlight CursorLineNr ctermfg=7
else
    if exists('neovim_dot_app')
        silent! colorscheme gruvbox
        set guifont=Fira\ Mono\ Medium\ for\ Powerline:h12
    else
        silent! colorscheme solarized
        highlight CursorLineNr guibg=#073642 guifg=#586e75 ctermfg=NONE ctermbg=0
    endif
endif

" Default to UTF-8 and Unix line endings, but use the existing line endings
" if the file already has some.
if !has('nvim')
    set encoding=utf8
    scriptencoding utf-8
endif
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
if v:version > 703 || v:version == 703 && has('patch541')
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

" Search for tags in the current working directory, then recursively upwards
" until /.
set tags=tags;/,codex.tags;/

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

let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

map <leader>tg :!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>

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
nnoremap <leader>a :Ack!<space>

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

" FIXME: Temporary until Neovim.app fixes meta key
nnoremap ∆ mz:m+<cr>`z
nnoremap ˚ mz:m-2<cr>`z

" Trying these out...
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" Visual mode mappings. {{{2
" Visual line transposition.
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" FIXME: Temporary until next Neovim release.
vnoremap ∆ :m'>+<cr>`<my`>mzgv`yo`z
vnoremap ˚ :m'<-2<cr>`>my`<mzgv`yo`z

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

" Disabled in favor of vim-airline.
" set statusline=%{HasPaste()}[%n]\ %<%F%m%h\ :%Y:\ %{exists('*fugitive#statusline')?fugitive#statusline():''}\ %w\ \ %h\ \ %=%b\ %B\ Line:\ %l/%L:%c\ [%P]

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

" Prose writing settings. {{{1

function! ProseInit()
    call textobj#sentence#init()
    call litecorrect#init()
    call lexical#init()
    call pencil#init({'wrap': 'hard'})
endfunction

augroup prose
    autocmd!
    autocmd FileType markdown call ProseInit()
    autocmd FileType textile call ProseInit()
    autocmd FileType rst call ProseInit()
    autocmd FileType text call ProseInit()
    autocmd FileType gitcommit call ProseInit() | call pencil#init({'wrap': 'hard', 'autoformat': 0})
    autocmd FileType help call lexical#init({ 'spell': 0 })

    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
augroup END

let g:litecorrect#typographic = 0
let g:lexical#spell_key = 'zs'
let g:limelight_conceal_guifg = '#666666'

" Plugin settings. {{{1
" ALE Settings. {{{2

let g:ale_linters = {
\   'go': [],
\   'haskell': ['stack-ghc-mod', 'hdevtools', 'stack-build', 'hlint']
\}
let g:ale_sign_error = '●'

" Emmet settings. {{{2
let g:user_emmet_leader_key='<C-b>'
let g:user_emmet_settings = {
            \  'javascript.jsx' : {
            \      'extends' : 'jsx',
            \  },
            \}

" Gundo plugin configuration
nnoremap <leader>U :GundoToggle<CR>

" NERDTree plugin settings. {{{2
let g:NERDTreeBookmarksFile = $HOME . '/.vim/.NERDTreeBookmarks'
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\~$', '^tags$[[file]]', '\.beam$', '\.pyc$', '\.class$[[file]]', '^.git$[[dir]]', '\.js.map$']

nnoremap <leader>n :NERDTreeToggle<cr>

" CtrlP plugin settings. {{{2
" Set the max files
let g:ctrlp_max_files = 10000

if has('win32')
    let g:ctrlp_user_command = {
                \   'types': {
                \       1: ['.git/', 'cd %s && git ls-files --exclude-standard -co'],
                \       2: ['.hg/', 'cd %s && hg manifest']
                \   },
                \   'fallback': 'dir %s /-n /b /s /a-d | findstr /V "\.dropbox\.cache\\ \.git\\ \.hg\\"'
                \ }
endif

" Set CtrlP's working directory to the VCS project root, or vim's current
" directory if the current file is under it, or the directory of the current
" file, in that order.
let g:ctrlp_working_path_mode = 'ra'

" Hide hidden files when not using ctrlp_user_command.
let g:ctrlp_show_hidden = 0

" Ignore common VCS directories and various other uneditables when not using
" ctrlp_user_command.
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v\.dropbox\.cache$\|\.git$\|\.hg$\|\.svn$',
  \ 'file': '\v\.(exe|so|dll|o|pyc|beam)$',
  \ }

let g:ctrlp_map = '<leader>ff'
nnoremap <leader>fF :CtrlPCurWD<CR>
nnoremap <leader>bb :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMixed<CR>
nnoremap <leader>M :CtrlPMRUFiles<CR>
nnoremap <leader>tt :CtrlPTag<CR>
nnoremap <leader>tT :CtrlPBufTag<CR>
nnoremap <leader>ll :CtrlPLine<CR>

let g:ctrlp_extensions = ['mixed', 'tag', 'buffertag', 'line', 'undo', 'changes', 'dir']


" YankRing plugin settings. {{{2
let g:yankring_history_dir = '~/.vim'

" vim-session plugin settings. {{{2
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 5
let g:session_autoload = 'no'
let g:session_directory = '~/.vim/sessions'
set sessionoptions+=resize,winpos
set sessionoptions-=help

" vim-airline plugin settings. {{{2
let g:airline_powerline_fonts = 1
set noshowmode
let g:airline_section_y = '%{airline#util#wrap(airline#parts#ffenc(),0)}%{PencilMode()}'

" vim-gitgutter plugin settings. {{{2
highlight! link GitGutterAdd DiffAdd
highlight! link GitGutterChange DiffChange
highlight! link GitGutterDelete DiffDelete

" vim-gutentags plugin settings. {{{2
" from: https://github.com/ludovicchabant/vim-gutentags/issues/82
let g:gutentags_enabled_dirs = ['~/src', '~/.dotfiles']
let g:gutentags_enabled_user_func = 'CheckEnabledDirs'

function! CheckEnabledDirs(file)
    let l:file_path = fnamemodify(a:file, ':p:h')

    try
        let l:gutentags_root = gutentags#get_project_root(l:file_path)
        if filereadable(l:gutentags_root . '/.withtags')
            return 1
        endif
    catch
    endtry

    for l:enabled_dir in g:gutentags_enabled_dirs
        let l:enabled_path = fnamemodify(l:enabled_dir, ':p:h')

        if match(l:file_path, l:enabled_path) == 0
            return 1
        endif
    endfor

    return 0
endfunction

" Mundo plugin settings. {{{2
nnoremap <leader>u :MundoToggle<CR>
let g:mundo_right = 1
let g:mundo_close_on_revert = 1

" SuperTab plugin settings. {{{2
if has('autocmd') && exists('+omnifunc')
    augroup omnicomp
        autocmd!
        autocmd FileType * if &omnifunc != "" | call SuperTabChain(&omnifunc, "<c-p>") | endif
    augroup END
endif

" tslime settings. {{{2
let g:tslime_ensure_trailing_newlines = 1
vmap <silent> <Leader>rs <Plug>SendSelectionToTmux
nmap <silent> <Leader>rs <Plug>NormalModeSendToTmux
nmap <silent> <Leader>rv <Plug>SetTmuxVars

" Ultisnips plugin settings. {{{2
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsSnippetsDir=expand('<sfile>:p:h') . '/UltiSnips'

" Language settings. {{{1
" C language settings. {{{2
augroup c
    autocmd!
    autocmd Filetype C compiler gcc
augroup END

" C++ language settings. {{{2
augroup cpp
    autocmd!
    autocmd Filetype cpp compiler gcc
augroup END

" Coffeescript language settings. {{{2
augroup coffeescript
    autocmd!
    autocmd BufNewFile,BufReadPost *.coffee setlocal foldmethod=indent nofoldenable
    autocmd BufNewFile,BufReadPost *.coffee setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd BufWritePost *.coffee make
augroup END

" Elixir language settings. {{{2

" Erlang language settings. {{{2

" Elm language settings. {{{2
let g:elm_format_autosave = 1

" Fish scripting language settings. {{{2
augroup fish
    autocmd!
    autocmd FileType fish compiler fish
    autocmd FileType fish setlocal foldmethod=expr
augroup END

" Go language settings. {{{2
let g:go_disable_autoinstall = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:go_auto_type_info = 1
let g:go_fmt_command = 'goimports'

let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'staticcheck']


augroup golang
    autocmd!
    autocmd BufNewFile,BufReadPost *.go setlocal tabstop=4 nolist
    autocmd FileType go nmap <buffer> <LocalLeader>r <Plug>(go-run)
    autocmd FileType go nmap <buffer> <LocalLeader>b <Plug>(go-build)
    autocmd FileType go nmap <buffer> <LocalLeader>t <Plug>(go-test)
    autocmd FileType go nmap <buffer> <LocalLeader>c <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <buffer> <LocalLeader>gd <Plug>(go-doc)
    autocmd FileType go nmap <buffer> <LocalLeader>gv <Plug>(go-doc-vertical)
    autocmd FileType go nmap <buffer> <LocalLeader>gb <Plug>(go-doc-browser)
    autocmd FileType go nmap <buffer> <LocalLeader>s <Plug>(go-implements)
    autocmd FileType go nmap <buffer> <LocalLeader>i <Plug>(go-info)
    autocmd FileType go nmap <buffer> <LocalLeader>e <Plug>(go-rename)
augroup END

" Haskell language settings. {{{2
augroup haskell
    autocmd!
    autocmd FileType haskell let &formatprg="stylish-haskell"
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    autocmd FileType haskell setlocal csprg=hscope
    autocmd FileType haskell call SuperTabSetDefaultCompletionType("<c-x><c-o>")
    autocmd FileType haskell let g:ghcmod_use_basedir = getcwd()
    autocmd FileType haskell nmap <buffer> <silent> <leader>hw :GhcModTypeInsert<CR>
    autocmd FileType haskell nmap <buffer> <silent> <localleader>s :GhcModSplitFunCase<CR>
    autocmd FileType haskell nmap <buffer> <silent> <localleader>g :GhcModSigCodegen<CR>

    autocmd FileType Haskell nnoremap <buffer> <silent> <C-l> :<C-u>nohlsearch<CR>:GhcModTypeClear<CR><C-l>
    " Type of expression under cursor
    autocmd FileType haskell nmap <buffer> <silent> <localleader>t :GhcModType<CR>
    autocmd FileType haskell nmap <buffer> <silent> <localleader>c :GhcModTypeClear<CR>
    " Insert type of expression under cursor
    autocmd FileType haskell nmap <buffer> <silent> <localleader>T :GhcModTypeInsert<CR>
    autocmd FileType haskell setlocal csto=1 " search codex tags first
    autocmd FileType haskell setlocal cst
    autocmd FileType haskell setlocal csverb
    autocmd FileType haskell call LoadHscope()

    " Hoogle the word under the cursor
    autocmd FileType haskell nnoremap <buffer> <silent> <localleader>h :Hoogle<CR>

    " Hoogle and prompt for input
    autocmd FileType haskell nnoremap <buffer> <localleader>H :Hoogle<space>

    " Hoogle for detailed documentation (e.g. "Functor")
    autocmd FileType haskell nnoremap <buffer> <silent> <localleader>i :HoogleInfo<CR>

    " Hoogle for detailed documentation and prompt for input
    autocmd FileType haskell nnoremap <buffer> <localleader>I :HoogleInfo<space>

    " Hoogle, close the Hoogle window
    autocmd FileType haskell nnoremap <buffer> <silent> <localleader>z :HoogleClose<CR>

    " Pointless keybindings
    autocmd FileType haskell vnoremap <buffer> <silent> <localleader>. :Pl<CR>
    autocmd FileType haskell vnoremap <buffer> <silent> <localleader>> :Unpl<CR>
augroup END
let g:haddock_browser = 'google-chrome'
let g:haskell_tabular = 1
let g:necoghc_enable_detailed_browse = 1

function! LoadHscope()
  let l:db = findfile('hscope.out', '.;')
  if (!empty(l:db))
    let l:path = strpart(l:db, 0, match(l:db, '/hscope.out$'))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe 'cs add ' . l:db . ' ' . l:path
    set cscopeverbose
  endif
endfunction

" This uses pointfree for refactoring Haskell code to pointfree form
" This requires the pointfree package:
" <http://hackage.haskell.org/package/pointfree>
command! -range Pl <line1>,<line2>!pointfree "$(cat)"

" The following refactors Haskell code into pointful form.
" Requires the pointful package:
" <http://hackage.haskell.org/package/pointful>
command! -range Unpl <line1>,<line2>!pointful "$(cat)" | sed 's/^(\(.*\))$/\1/'

" Idris language settings. {{{2
let g:idris_conceal = 1

" HTML language settings. {{{2
let g:closetag_html_style=1

" Javascript language settings. {{{2
augroup javascript
    autocmd!
    autocmd FileType javascript setlocal foldenable
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
augroup END

let g:used_javascript_libs = 'underscore,jquery,angularjs,react,jasmine,handlebars,ramda,chai,vue,d3'
let g:jsx_ext_required = 0

" LaTeX language settings. {{{2
" Temporarily kept for reference while setting up LaTeXBox
" let g:Tex_DefaultTargetFormat="pdf"
" let g:Tex_MultipleCompileFormats="dvi,pdf"
" let g:Tex_ViewRule_pdf="sumatrapdf -reuse-instance" " TODO: Make cross-platform.
" let g:Tex_CompileRule_pdf = 'pdflatex --synctex=-1 -src-specials -interaction=nonstopmode $*'
" let g:Tex_AutoFolding=0
let g:LatexBox_latexmk_preview_continuously=1
let g:LatexBox_quickfix=2
let g:LatexBox_output_type='pdf'
let g:LatexBox_Folding=1
if has('gui')
    let g:LatexBox_latexmk_async=1
endif
let g:tex_flavor='latex'

" Lisp language settings. {{{2
augroup lisp
    autocmd!
    autocmd BufNewFile,BufReadPost *.cl set lisp
augroup END

" Mustache templating settings. {{{2
augroup mustache
    autocmd!
    autocmd BufRead,BufNewFile *.html,*.htm,*.xhtml set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
augroup END

" Mutt format settings. {{{2
" Set filetype to mail when editing emails for mutt.
augroup mutt
    autocmd!
    autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

" OCaml language settings. {{{2
if executable('opam')
    let s:ocamlshare = substitute(system('opam config var share'), '\n$', '', '''')
    if executable('ocp-indent')
        augroup ocaml
            autocmd!
            autocmd FileType ocaml unlet b:did_indent
            autocmd FileType ocaml execute "source " . s:ocamlshare . "/ocp-indent/vim/indent/ocaml.vim"
            autocmd FileType ocaml let b:did_indent = 1
        augroup END
    endif
    if executable('ocamlmerlin') && has('python')
        let s:ocamlshare = substitute(system('opam config var share'), '\n$', '', '''')
        let s:ocamlmerlin = s:ocamlshare . '/merlin'
        execute 'set rtp+='.s:ocamlmerlin.'/vim'
        execute 'set rtp+='.s:ocamlmerlin.'/vimbufsync'
    endif
endif

" Python language settings. {{{2
augroup python
    autocmd!
    autocmd FileType python set nosmartindent
augroup END

" PureScript language settings. {{{2
augroup purescript
    autocmd!
    autocmd BufWritePost *.purs Prebuild
augroup END
" Reason language settings. {{{2

" Ruby language settings. {{{2
augroup ruby
    autocmd!
    autocmd BufNewFile,BufRead *_spec.rb compiler rspec
    autocmd BufNewFile,BufReadPost *.rb setlocal foldmethod=indent nofoldenable
    autocmd BufNewFile,BufReadPost *.rb setlocal shiftwidth=2 expandtab
augroup END

" Rust language settings. {{{2

" Typescript language settings. {{{2
let g:tsuquyomi_disable_quickfix = 1

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
let g:ayucolor='light'

if has('gui_gtk')
    set guioptions-=m
endif