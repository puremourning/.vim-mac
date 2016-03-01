
" Map YouCompleteMe shortcut

nnoremap <silent> <Plug>YcmMappingGetTypeQuick :YcmCompleter GetTypeQuick<CR>
            \ :call repeat#set("\<Plug>YcmMappingGetTypeQuick")<CR>
nnoremap <silent> <Plug>YcmMappingGetType :YcmCompleter GetType<CR>
            \ :call repeat#set("\<Plug>YcmMappingGetType")<CR>
nnoremap <silent> <Plug>YcmMappingFixItQuick :YcmCompleter FixItQuick<CR>
            \ :call repeat#set("\<Plug>YcmMappingFixItQuick")<CR>
nnoremap <silent> <Plug>YcmMappingFixIt :YcmCompleter FixIt<CR>
            \ :call repeat#set("\<Plug>YcmMappingFixIt")<CR>
nnoremap <silent> <Plug>YcmMappingGoToImprecise :YcmCompleter YcmGoToImprecise<CR>
            \ :call repeat#set("\<Plug>YcmMappingGoToImprecise")<CR>
nnoremap <silent> <Plug>YcmMappingGoTo :YcmCompleter GoTo<CR>
            \ :call repeat#set("\<Plug>YcmMappingGoTo")<CR>
nnoremap <silent> <Plug>YcmMappingGetDoc :YcmCompleter GetDoc<CR>
            \ :call repeat#set("\<Plug>YcmMappingGetDoc")<CR>
nnoremap <silent> <Plug>YcmMappingGetDocQuick :YcmCompleter GetDocQuick<CR>
            \ :call repeat#set("\<Plug>YcmMappingGetDocQuick")<CR>

nmap <leader>ygt   <Plug>YcmMappingGetTypeQuick
nmap <leader>ygT   <Plug>YcmMappingGetType
nmap <leader>yfi   <Plug>YcmMappingFixItQuick
nmap <leader>yfI   <Plug>YcmMappingFixIt
nmap <leader>ygd   <Plug>YcmMappingGoToImprecise
nmap <leader>ygD   <Plug>YcmMappingGoTo
nmap <leader>ysD   <Plug>YcmMappingGetDoc
nmap <leader>ysd   <Plug>YcmMappingGetDocQuick

nmap <leader>p :pclose!<cr>
