scriptencoding utf-8

if 1 && filereadable($VIM . '/gvimrc_local.vim')
  source $VIM/gvimrc_local.vim
  if exists('g:gvimrc_local_finish') && g:gvimrc_local_finish != 0
    finish
  endif
endif

if 0 && exists('$HOME') && filereadable($HOME . '/.gvimrc_first.vim')
  unlet! g:gvimrc_first_finish
  source $HOME/.gvimrc_first.vim
  if exists('g:gvimrc_first_finish') && g:gvimrc_first_finish != 0
    finish
  endif
endif

if 1 && (!exists('g:no_gvimrc_example') || g:no_gvimrc_example == 0)
  source $VIMRUNTIME/gvimrc_example.vim
endif

set background=dark
colorscheme base16-isotope

if has('win32')
  set guifont=Ricty:h10:cSHIFTJIS
  set linespace=1
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=Osaka－等幅:h14
elseif has('xfontset')
  set guifontset=a14,r14,k14
endif

set columns=120
set lines=40
set cmdheight=2
set number

if has('multi_byte_ime') || has('xim')
  highlight CursorIM guibg=Purple guifg=NONE
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
  endif
endif

set mouse=a
set nomousefocus
set mousehide

if &guioptions =~# 'M'
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
endif


if has('printer')
  if has('win32')
    set printfont=Ricty:h12:cSHIFTJIS
  endif
endif

source $VIMRUNTIME/mswin.vim

nmap <C-Tab> :tabn<CR>
nmap <C-S-Tab> :tabp<CR>
nmap <C-t> :tabnew<CR>

set tabstop=4
set shiftwidth=4

set encoding=utf-8
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
