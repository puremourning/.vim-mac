" Map YouCompleteMe shortcut

nnoremap <silent> <Plug>YcmMappingGetType :YcmCompleter GetType<CR>
            \:call repeat#set("\<Plug>YcmMappingGetType")<CR>
nnoremap <silent> <Plug>YcmMappingFixIt :YcmCompleter FixIt<CR>
            \:call repeat#set("\<Plug>YcmMappingFixIt")<CR>
nnoremap <silent> <Plug>YcmMappingGoTo :YcmCompleter GoTo<CR>
            \:call repeat#set("\<Plug>YcmMappingGoTo")<CR>
nnoremap <silent> <Plug>YcmMappingGetDoc :YcmCompleter GetDoc<CR>
            \:call repeat#set("\<Plug>YcmMappingGetDoc")<CR>
nnoremap <silent> <Plug>YcmMappingGoToReferences :YcmCompleter GoToReferences<CR>
            \:call repeat#set("\<Plug>YcmMappingGoToReferences")<CR>

nmap <leader>ygt   <Plug>YcmMappingGetType
nmap <leader>ygT   <Plug>YcmMappingGetType
nmap <leader>yfi   <Plug>YcmMappingFixIt
nmap <leader>yfI   <Plug>YcmMappingFixIt
nmap <leader>ygd   <Plug>YcmMappingGoTo
nmap <leader>ygD   <Plug>YcmMappingGoTo
nmap <leader>ysD   <Plug>YcmMappingGetDoc
nmap <leader>ysd   <Plug>YcmMappingGetDoc
nmap <leader>ygr   <Plug>YcmMappingGoToReferences
nmap <leader>ygR   <Plug>YcmMappingGoToReferences
nnoremap <leader>ygS
            \:<C-u>execute 'YcmCompleter GoToSymbol '.input('Symbol: ')<CR>
nnoremap <leader>ygs
            \:<C-u>execute 'YcmCompleter GoToSymbol '.input('Symbol: ')<CR>

nmap <leader>D <Plug>(YCMHover)
nmap <localleader>yfw <Plug>(YCMFindSymbolInWorkspace)
nmap <localleader>yfd <Plug>(YCMFindSymbolInDocument)
nmap <localleader>ygd <Plug>(YCMPEditDefinition)
nmap <silent> <localleader>h <Plug>(YCMToggleInlayHints)
nnoremap <silent> <localleader>ysd <cmd>YcmShowDetailedDiagnostic<CR>

" I hever use i_CTRL-E and i_CTRL-Y. While i hate overriding the builtin
" function, this is more common for me.
inoremap <silent> <C-E> <Plug>(YCMToggleSignatureHelp)
 
augroup CustYCMHover
  autocmd!
  autocmd FileType c,cpp,objc let b:ycm_hover = {
        \ 'command': 'GetDoc',
        \ 'syntax': &syntax
        \ }
augroup END

nmap <leader>p :pclose!<cr>

