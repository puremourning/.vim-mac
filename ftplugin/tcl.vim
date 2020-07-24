" Jump to any tag which ends with the word under the cursor. This helps where
" the tag is abc::def::xyz and the word is xyz
nnoremap <silent> <buffer> <leader><C-]>
      \ :<C-u>execute 'tjump /' . expand( '<cword>' ) . '$'<CR>
