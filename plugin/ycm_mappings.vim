
" Map YouCompleteMe shortcut

nnoremap <silent> <Plug>YcmGetTypeQuick :YcmCompleter GetTypeQuick<CR>
            \ :call repeat#set("\<Plug>YcmGetTypeQuick")<CR>
nnoremap <silent> <Plug>YcmGetType :YcmCompleter GetType<CR>
            \ :call repeat#set("\<Plug>YcmGetType")<CR>
nnoremap <silent> <Plug>YcmFixItQuick :YcmCompleter FixItQuick<CR>
            \ :call repeat#set("\<Plug>YcmFixItQuick")<CR>
nnoremap <silent> <Plug>YcmFixIt :YcmCompleter FixIt<CR>
            \ :call repeat#set("\<Plug>YcmFixIt")<CR>

nmap <leader>ygt   <Plug>YcmGetTypeQuick
nmap <leader>ygT   <Plug>YcmGetType
nmap <leader>yfi   <Plug>YcmFixItQuick
nmap <leader>yfI   <Plug>YcmFixIt
