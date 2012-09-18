" forward / backward in time by date jumping
let date_fmt = '\d\{2\}\.\d\{2\}\.\d\{2\}'
nmap <S-d> :call Jump2Search('^' . date_fmt . '$')<CR>
nmap <S-u> :call Jump2Search('^' . date_fmt . '$', 'b')<CR>
