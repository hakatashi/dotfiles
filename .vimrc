scriptencoding utf-8

set nocompatible

set ignorecase
set smartcase
set expandtab
set autoindent
set backspace=indent,eol,start
set wrapscan
set showmatch
set wildmenu
set formatoptions+=mM
set number
set ruler
set nolist
set nowrap
set laststatus=2
set cmdheight=2
set showcmd
set title
set background=dark
set tabstop=4
set shiftwidth=4
set encoding=utf-8
set langmenu=ja_jp.utf-8
set formatexpr=autofmt#japanese#formatexpr()
set history=50
set incsearch
set list
set listchars=tab:»\ ,trail:-,eol:↲,extends:»,precedes:«
set shell=/bin/bash
set breakindent

" NeoBundle Settings
if !1 | finish | endif
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" My Bundles here:
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'othree/html5.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'vim-scripts/AfterColors.vim'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'vim-scripts/nginx.vim'
NeoBundle 'powerman/vim-plugin-AnsiEsc'
NeoBundle 'StanAngeloff/php.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'shawncplus/phpcomplete.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'bling/vim-airline'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'moll/vim-node'
NeoBundle 'guileen/vim-node-dict'
NeoBundle 'vim-scripts/po.vim--Jelenak'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'markcornick/vim-vagrant'
NeoBundle 'vim-scripts/smarty-syntax'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'vim-scripts/gnuplot.vim'
NeoBundle 'digitaltoad/vim-jade'
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload': {'filetypes': ['javascript']}}
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

vnoremap <silent> <C-p> "0p<CR>

let base16colorspace=256  " Access colors present in 256 colorspace"
set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm
colorscheme base16-isotope

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent
endif

if !(has('win32') || has('mac')) && has('multi_lang')
  if !exists('$LANG') || $LANG.'X' ==# 'X'
    if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
      language ctype ja_JP.eucJP
    endif
    if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
      language messages ja_JP.eucJP
    endif
  endif
endif

if has('mac')
  set langmenu=japanese
  set iskeyword=@,48-57,_,128-167,224-235
endif

if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
  set termencoding=cp932
endif

if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif

if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  set tags=./tags,tags
endif

if has('unix') && !has('gui_running')
  let s:uname = system('uname')
  if s:uname =~? "linux"
    set term=builtin_linux
  elseif s:uname =~? "freebsd"
    set term=builtin_cons25
  elseif s:uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet s:uname
endif

if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mouse')
  set mouse=a
  set ttymouse=xterm2
endif

" Tab mover things
nmap <C-Tab> :tabn<CR>
nmap <C-S-Tab> :tabp<CR>
nmap <C-t> :tabnew<CR>

" Indent things
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >>
vmap <S-Tab> <<
imap <S-Tab> <Esc><<i

" Auto-indented paste
nmap p ]p

" Move through wrapped lines
" http://vim.wikia.com/wiki/Move_through_wrapped_lines
" imap <silent> <Down> <C-o>gj
" imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
" Additional
nmap <silent> j gj
nmap <silent> k gk

source $VIMRUNTIME/mswin.vim

let g:neocomplcache_enable_at_startup = 1
let g:airline_powerline_fonts = 1

" Unbind Shift-k and Shift-j, which are very often to misstype
nnoremap J <Nop>
nnoremap K <Nop>
