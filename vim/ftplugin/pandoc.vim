" jump around headers in text
nmap <buffer> <S-d> :call Jump2Search('^#')<CR>
nmap <buffer> <S-u> :call Jump2Search('^#', 'b')<CR>
