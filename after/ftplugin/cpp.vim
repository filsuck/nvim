"setlocal fdm=
setlocal fdm=expr
setlocal foldexpr=GetIndentFold(v:lnum)
setlocal foldlevel=1
nnoremap <buffer> gh   :call ToggleHeader()<CR>
nnoremap <buffer> <F4> :call ToggleHeader()<CR>

nnoremap <buffer> <leader>yc :YcmCompleter<space>
