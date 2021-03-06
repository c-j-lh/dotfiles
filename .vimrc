"set runtimepath^=~/.vim/bundle/novim-mod

set nocompatible
nnoremap n nzz
nnoremap } }zz
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
set linebreak
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>
set gdefault
set virtualedit=block
set splitbelow
set splitright

set showmode
set nu
set showcmd
set mouse=a
set clipboard=unnamedplus
set dir=~/.vim/swapfiles//
let mapleader = ","

"Undo, swap and backup files {{{
" Save your backup files to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or .
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup//
set backupdir^=./.vim-backup//
set backup

" Save your swap files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backup files, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif
"}}}

nnoremap <leader>ev :sp ~/.vimrc<cr>
nnoremap <leader>sv :so ~/.vimrc<cr>
nnoremap <leader>9 `>a)<esc>`<i(<esc
nnoremap x "_x
nnoremap m "_d
nnoremap mm "_dd
nnoremap M "_D
nnoremap Y y$
"nnoremap cc ^c$  " Doesn't work for multiple lines
vnoremap m d

inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap " ""<left>
inoremap ' ''<left>
autocmd FileType cpp inoremap < <><left>


" indents {{{
    set shiftwidth=4  " Set number of spaces per auto indentation
    set expandtab     " When using <Tab>, put spaces instead of a <tab> character
    set tabstop=4   " Number of spaces that a <Tab> in the file counts for
    set smarttab    " At <Tab> at beginning line inserts spaces set in shiftwidth
" }}}

" Python and indents {{{
augroup python
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType python iabbrev fr for i in range()<esc>i

    " For uncommenting and commenting CS1010S lines
    autocmd FileType python nnoremap <leader>b :,+6s/^\zeprint/#<cr>
    autocmd FileType python nnoremap <leader>n :,+6s/^#\s*\zeprint//<cr>
    autocmd FileType python set foldmethod=syntax

    " indent {{{
        " ---- Minimal configuration:
        autocmd FileType python set shiftwidth=4  " Set number of spaces per auto indentation
        autocmd FileType python set expandtab     " When using <Tab>, put spaces instead of a <tab> character

        " ---- Good to have for consistency
        autocmd FileType python set tabstop=4   " Number of spaces that a <Tab> in the file counts for
        autocmd FileType python set smarttab    " At <Tab> at beginning line inserts spaces set in shiftwidth
    " }}}
    augroup END
"}}}

set smartindent   " Do smart autoindenting when starting a new line

" Vimscript {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}


" F5/F9 running files {{{
filetype on
autocmd FileType python nnoremap <buffer> <F9> :w<CR>:exec '!clear; python3' shellescape(@%, 1)<cr>
autocmd FileType python inoremap <buffer> <F9> :w<CR>:exec '!clear; python3' shellescape(@%, 1)<cr>
autocmd Filetype python nnoremap <buffer> <F5> :w<CR>:exec '!clear; python3 -i ' shellescape(@%, 1)<cr>
autocmd Filetype python inoremap <buffer> <F5> :w<CR>:exec '!clear; python3 -i ' shellescape(@%, 1)<cr>
autocmd Filetype matlab noremap <buffer> <F5> :w<CR>:exec '!clear; octave --persist ' shellescape(@%, 1)<cr>
" }}}

" For fun {{{
augroup save
    autocmd!
    autocmd BufNewFile *.txt :write
augroup END

" Markdown {{{
augroup markdown
    autocmd!
    autocmd FileType markdown onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType markdown onoremap ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>
    autocmd FileType markdown setlocal statusline+=:))%%
augroup END
onoremap an( :<c-u>normal! f(va(<cr>
onoremap al( :<c-u>normal! F)va(<cr>
" }}}
" }}}
