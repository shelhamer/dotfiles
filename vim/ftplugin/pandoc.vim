" jump around headers in text
nmap <buffer> <S-d> :call Jump2Search('^#')<CR>
nmap <buffer> <S-u> :call Jump2Search('^#', 'b')<CR>

" read paper, take notes from cite-key
map <silent> <leader>r :call ReadPaper()<CR>
map <silent> <leader>n :call NotePaper()<CR>

" open file w/ default handler
map <silent> <leader>g :call OpenResource()<CR>

" get citekey under cursor
function! CiteKey()
  let cite = expand('<cWORD>')
  let cite = strpart(cite, 1)
  return cite
endfunction

" open paper from citekey
function! ReadPaper()
  let paper_file = g:papers_directory . CiteKey() . '.pdf'
  silent exec '!open ' . paper_file
endfunction

" open notes for paper from citekey
function! NotePaper()
  let note_file = g:notes_directory . '/' . CiteKey() . g:notes_suffix
  exec ':e ' . note_file
endfunction

" open resource w/ default handler for OS (paths, URLs, and emails)
function! OpenResource()
  let resource = expand('<cWORD>')
  " URL
  if matchstr(resource, '\<\(\w\+://\)\(\S*\w\)\+/\?') != ''
    call ShellOpen(resource)
  " email
  elseif matchstr(resource, '\%(\p\|\.\|_\|-\|+\)\+@\%(\p\+\.\)\p\+') != ''
    call ShellOpen('mailto:' . resource)
  " path (last b.c. of complicated match)
  elseif matchstr(getline('.'), '\[[^\]]\+]') != ''
    " capture text in delimiters around cursor
    let l = line('.')
    let c = col('.')
    norm vi[y
    let path = expand(getreg('0'))
    " undo side effects
    call setreg('0','')
    call cursor(l,c)
    " check access, open file
    if !(isdirectory(path) || filereadable(path))
      echo "shell: " . path . " couldn't be opened."
    else
      call ShellOpen(path)
    endif
  else
    echo "shell: couldn't find a known resource to open"
  endif
endfunction

function! ShellOpen(resource)
  silent exec '!open ' . shellescape(a:resource)
endfunction

" syntax: filepaths, URLs, emails

syntax match noteFilePath /\[[^\]]\+\]/
hi def link noteFilePath Label

syntax match noteURL @\<\(\w\+://\)\(\S*\w\)\+/\?@
hi def link noteUrl Label

syntax match noteMail /\%(\p\|\.\|_\|-\|+\)\+@\%(\p\+\.\)\p\+/
hi def link noteMail Label
