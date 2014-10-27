scriptencoding utf-8

set mouse=a
set nomousefocus
set mousehide
set columns=120
set lines=40
set cmdheight=2
set number
set background=dark
colorscheme base16-isotope

if has('win32')
  set guifont=Ricty:h10:cSHIFTJIS
  set linespace=1
elseif has('mac')
  set guifont=Osaka－等幅:h14
elseif has('xfontset')
  set guifontset=a14,r14,k14
endif

if has('multi_byte_ime') || has('xim')
  highlight CursorIM guibg=Purple guifg=NONE
  set iminsert=0 imsearch=0
endif

if &guioptions =~# 'M'
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
endif

if has('printer')
  if has('win32')
    set printfont=Ricty:h12:cSHIFTJIS
  endif
endif

command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
