" jump around headers in text
nmap <S-d> :call Jump2Search('^#')<CR>
nmap <S-u> :call Jump2Search('^#', 'b')<CR>
