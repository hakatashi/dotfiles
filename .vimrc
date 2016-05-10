set encoding=utf-8
scriptencoding utf-8

set nocompatible

set list
set ruler
set title
set nowrap
set number
set showcmd
set wildmenu
set wrapscan
set expandtab
set showmatch
set incsearch
set smartcase
set tabstop=4
set autoindent
set ignorecase
set history=50
set breakindent
set cmdheight=2
set shiftwidth=4
set laststatus=2
set background=dark
set formatoptions+=mM
set langmenu=ja_jp.utf-8
set backspace=indent,eol,start
set formatexpr=autofmt#japanese#formatexpr()
set listchars=tab:»\ ,trail:-,eol:↲,extends:»,precedes:«

" Explicitly specify shell name according to the platform
" https://github.com/mattn/gist-vim/issues/48#issuecomment-12916349
" http://milkandtang.com/blog/2013/03/22/vim-fish-shell-and-sensible/
if has('win32')
  set shell=cmd
  set shellcmdflag=/c
else
  set shell=/bin/bash
endif

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
NeoBundle 'gkz/vim-ls'
NeoBundle 'moll/vim-node'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'StanAngeloff/php.vim'
NeoBundle 'guileen/vim-node-dict'
NeoBundle 'vim-scripts/nginx.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'vim-scripts/gnuplot.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'markcornick/vim-vagrant'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'vim-scripts/smarty-syntax'
NeoBundle 'shawncplus/phpcomplete.vim'
NeoBundle 'vim-scripts/po.vim--Jelenak'
NeoBundle 'vim-scripts/AfterColors.vim'
NeoBundle 'powerman/vim-plugin-AnsiEsc'
NeoBundle 'jeetsukumaran/vim-indentwise'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload': {'filetypes': ['javascript']}}
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" Settings about 256 colors
" http://vim.wikia.com/wiki/256_colors_in_vim
set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm

" Use 256-colored colorscheme
" https://github.com/chriskempson/base16-vim#256-colorspace
let base16colorspace=256
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

" Special setting for ConEmu
" http://conemu.github.io/en/VimXterm.html
if has('win32') && !has("gui_running")
  " 256-color
  set term=xterm
  set t_Co=256
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
  colorscheme slate

  " Enable mouse interaction
  set mouse=a
  inoremap <Esc>[62~ <C-X><C-E>
  inoremap <Esc>[63~ <C-X><C-Y>
  nnoremap <Esc>[62~ <C-E>
  nnoremap <Esc>[63~ <C-Y>
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

" Use C-p to paste strings constantly.
" http://qiita.com/fukajun/items/bd97a9b963dae40b63f5
vnoremap <silent> <C-p> "0p<CR>

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
"imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
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
