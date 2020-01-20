set autoread
set nocompatible
set nowritebackup
set paste
set hlsearch
autocmd BufNewFile,BufRead *.t set filetype=perl
autocmd BufNewFile,BufRead *.psgi set filetype=perl
autocmd BufNewFile,BufRead *.tt set filetype=html
autocmd BufNewFile,BufRead *.tx set filetype=html
autocmd BufNewFile,BufRead *.as set filetype=actionscript
autocmd BufNewFile,BufRead *.vue set filetype=html
autocmd BufNewFile,BufRead *.go set filetype=go
autocmd BufRead,BufNewFile *.vtc set filetype=vtc
autocmd FileType * setlocal formatoptions-=ro
autocmd FileType * set comments=

autocmd BufNewFile *.pl 0r $HOME/.vim/template/perl-script.txt
autocmd BufNewFile *.t  0r $HOME/.vim/template/perl-test.txt
function! s:pm_template()
    let path = substitute(expand('%'), '.*lib/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.pm$', '', 'g')
    call append(0, 'package ' . path . ';')
    call append(1, 'use strict;')
    call append(2, 'use warnings;')
    call append(3, 'use utf8;')
    call append(4, '')
    call append(5, '')
    call append(6, '')
    call append(7, '1;')
    call cursor(6, 0)
    " echomsg path
endfunction
autocmd BufNewFile *.pm call s:pm_template()

syntax on
set noautoindent
set nosmartindent
set tabstop=4
set expandtab
set shiftwidth=4
set encoding=utf-8
set fileencodings=utf-8
set notimeout
set ttimeout
set timeoutlen=100
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
highlight statusline term=NONE cterm=NONE ctermfg=black ctermbg=darkgray
set showmatch
set visualbell t_vb=
set noerrorbells

"nnoremap <C-c> :! perl -Ilib -c %<Enter>
"nnoremap <C-h> :! perl -Ilib %<Enter>
"nnoremap <C-p> :! prove -It/lib -l %<Enter>
inoremap <C-a> <c-x><c-o>
nnoremap <C-j> :noh<Enter>
nnoremap <C-i> :e<Enter>

hi Pmenu ctermbg=magenta
hi PmenuSel ctermbg=blue


" ======== dein
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let g:rc_dir    = expand('~/.vim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
" ======== dein end

filetype plugin indent on

augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
