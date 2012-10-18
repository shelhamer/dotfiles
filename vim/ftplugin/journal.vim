" forward / backward in time by date jumping
let date_fmt = '\d\{2\}\.\d\{2\}\.\d\{2\}'
nmap <buffer> <S-d> :call Jump2Search('^' . date_fmt . '$')<CR>
nmap <buffer> <S-u> :call Jump2Search('^' . date_fmt . '$', 'b')<CR>
