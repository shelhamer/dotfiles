"" general configuration

" vim, not vi
set nocompatible

" files
set title     " show filename in terminal title
set hidden    " hide buffers instead of closing, preserving the buffer
set autoread  " auto re-read files on change

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
set scrolloff=2   " scroll 2 lines away from border

" search
set hlsearch      " highlight search
set incsearch     " reveal search incrementally as typed
set ignorecase    " case-insensitive match...
set smartcase     " ...except when uppercase letters are given

set backspace=indent,eol,start  " backspace over everything
set pastetoggle=<F2>            " for pasting verbatim

" folding
set foldlevelstart=2  " unfold top level at start

" history
set history=1024    " number of commands, searches
set undofile
set undodir=~/.vim/tmp//
set undolevels=1024  " number of mistakes
set undoreload=16384 " number of lines to hold in undo buffer
set shortmess+=A " don't worry about existing swap files

" persistence:
" marks for 128 recent files
" registers < 256 lines and < 10k in size
" ignore hlsearch state on start
set viminfo='128,<256,s10,h
set directory=~/.vim/tmp//,/var/tmp//,/tmp//,.

" ignore types
set wildignore+=.svn,CVS,.git,*.pyc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bak,*.beam,*/tmp/*,*.zip,log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmode=longest,list,full

" syntax highlighting
syntax on

set background=dark
colorscheme egs-slate

" shell (bash, interactive)
set shell=/bin/bash\ -i

" unicode
set encoding=utf-8
setglobal fileencoding=utf-8

" spelling (w.o. capitalization check)
set spellfile=~/.vim/dict.add
set spellcapcheck=''

" no backups
set nobackup

" no annoying beeps
set visualbell
set noerrorbells

" no mode (see airline)
set noshowmode

" completion
set completeopt=longest,menuone

" sessions
set sessionoptions-=options

"" maps

let mapleader=','       " map by , instead of /
let maplocalleader='\'  " map local by \

" command by ;
map ; :

" fast navigation
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

" fast buffer alternation, next/prev, close
map ga <C-^>
nmap gn :bn<CR>
nmap gp :bp<CR>
nmap gk :bp<bar>bd #<CR>

" very magic search (sane regex)
nnoremap / /\v
vnoremap / /\v

" complete by tab
inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" clear search
nmap <silent> <leader>/ :nohlsearch<CR>

" fold/unfold
nmap <leader>z za

" wrap on Q, unwrap on C-Q
nmap Q gq
vmap Q gqa
nmap <C-Q> vipJ
vmap <C-Q> J

" case cycling
vmap ~ ygv"=TwiddleCase(@")<CR>Pgv

" spelling
nnoremap <silent> <leader>s :set spell!<CR>

" marked markdown view
nnoremap <leader>m :silent !open -a Marked\ 2 '%:p'<cr>

" vim session save/load
nmap ss :wa<CR>:mksession! ~/.vim/sessions/
nmap so :wa<CR>:so ~/.vim/sessions/

" vim hacking convenience: edit, reload .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"" functions

" jump to pattern
function! Jump2Search(...)
  let pattern = a:1
  let flags = ''
  if a:0 > 1
    let flags = a:2
  endif
  call search(pattern, flags)
  norm zt
endfunction

" alternate among lower/title/upper case
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction

" strip trailing whitespace
function! StripTrailing(...)
  let no_strip_types = []
  if a:0 > 0
    no_strip_types = a:1
  endif
  " save last search, cursor position
  let _s=@/
  let l = line('.')
  let c = col('.')
  if index(no_strip_types, &ft) < 0 " whitespace isn't evil for all files
    %s/\s\+$//e
  endif
  let @/=_s
  call cursor(l, c)
endfunction

" smart tab complete from http://vim.wikia.com/wiki/Smart_mapping_for_tab_completion
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

"" automation

" file types
filetype on
filetype indent on
filetype plugin on

" strip trailing whitespace on save
let no_strip_types = ['diff', 'markdown', 'pandoc']
autocmd BufWritePre *.* call StripTrailing(no_strip_types)

" python indent (disabled to give in to pep8)
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4

"" plugins

" pathogen
call pathogen#infect()

" status (airline)
set laststatus=2
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_theme = 'wombat'

let g:airline_left_sep = '▶'
let g:airline_right_sep = '◄'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" file finding (ctrlp)
let g:ctrlp_map = '<leader>t'
map <c-p>  :CtrlP getcwd()<CR>
let g:ctrlp_user_command = 'ag %s -l -f --nocolor -g ""' " silver searcher
let g:ctrlp_switch_buffer = '' " always open a new instance for side-by-side

" syntastic
let g:syntastic_mode_map = {'mode': 'passive',
                          \ 'active_filetypes': [],
                          \ 'passive_filetypes': []}
map <silent> <C-s> :SyntasticCheck<CR>

" python-mode
let g:pymode = 1
let g:pymode_folding = 1
let g:pymode_motion = 1
nmap <silent> <localleader>c :PymodeLint<CR>
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_bind = '<localleader>b'
let g:pymode_lint = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_message = 1
let g:pymode_lint_cwindow = 1
let g:pymode_lint_ignore = 'E111,E121,W0311'
let g:pymode_rope_completion = 0

" latex
let g:Tex_ViewRule_pdf = 'Skim'
"autocmd BufWritePost *.tex silent call Tex_RunLaTeX()

" notes
let g:notes_directory = '~/h/notebook/jot'
let g:notes_suffix = '.md'
let g:notes_title_sync = 'rename_file'
let g:notes_smart_quotes = 1
let g:notes_list_bullets = ['*', '-', '+']

" paper reading
let g:papers_directory = '~/h/notebook/papers/'

" pandoc
"let g:pandoc#modules#enabled = []
let g:pandoc#modules#disabled = ['folding']
let g:pandoc#formatting#mode = 'h'
let g:pandoc#biblio#sources = 'bcg'
let g:pandoc#biblio#bibs = [g:papers_directory . 'library.bib']
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#style#emphases = 0
let g:pandoc#syntax#style#underline_special = 0
autocmd Filetype pandoc set tw=0

" tabularize
nmap <leader>e :Tabularize /

" file explorer: tree view
let g:netrw_liststyle=3
