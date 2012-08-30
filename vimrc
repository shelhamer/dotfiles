" vim, not vi
set nocompatible

" files
set title     " show filename in terminal title
set hidden    " hide buffers instead of closing, preserving the buffer

" text width, wrap
set textwidth=80
set colorcolumn=81
set nowrap

" indentation
set autoindent    " always autoindent
set copyindent    " copy the previous indentation on autoindenting
set tabstop=2     " tab = 2 spaces
set softtabstop=2 " tab = 2 spaces (when deleting)
set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab     " spaces instead of tabs
set smarttab      " insert tabs on the start of a line according to
                  " shiftwidth, not tabstop

" spaces: show non-breaking (and mark long lines)
set list
set listchars=extends:#,nbsp:.

" navigation
set number        " number lines
set ruler         " show row, col of cursor

" search
set hlsearch      " highlight search
set incsearch     " reveal search incrementally as typed

set backspace=indent,eol,start  " backspace over everything
set pastetoggle=<F2>            " for pasting verbatim

" memory
set history=1000    " number of commands, searches
set undolevels=1000 " number of mistakes

" syntax highlighting
syntax on
colorscheme slate

" unicode
set encoding=utf-8
setglobal fileencoding=utf-8

" no backups
set nobackup
set noswapfile

" no annoying beeps
set visualbell
set noerrorbells

" custom bindings
let mapleader=','   " map by , instead of /

" command by ;
nnoremap ; :

" fast navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" clear search
nmap <silent> ,/ :nohlsearch<CR>

" reflow on Q
nmap Q gq
vmap Q gqap

" vim hacking convenience: edit, reload .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" automation

" file types
filetype on
filetype indent on
filetype plugin on

" strip trailing whitespace on save
autocmd BufWritePre *.* call StripTrailing()
let g:no_strip_types = ['diff', 'markdown', 'pandoc']

function! StripTrailing()
  normal mZ
  if index(g:no_strip_types, &ft) < 0 " whitespace isn't evil in markdown
    %s/\s\+$//e
  endif
  normal `Z
endfunction

" plugins: pathogen
call pathogen#infect()
call pathogen#helptags()

" latex
let g:Tex_ViewRule_pdf = 'Preview'

" notes
let g:notes_directory = '~/h/notebook/jot'
let g:notes_suffix = '.md'
let g:notes_title_sync = 'rename_file'
let g:notes_smart_quotes = 1
let g:notes_list_bullets = ['*', '-', '+']

" pandoc
let g:pandoc_use_hard_wraps = 1
