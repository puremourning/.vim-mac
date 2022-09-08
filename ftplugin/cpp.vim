"if ! has( 'gui_running' )
"  " ƒ is right-option+b
"  nnoremap <buffer> ∫ :w<CR>:Make<CR>
"  " ∑ is the right-option+w
"  nnoremap <buffer> ∑ :cnext<CR>
"  " ∑ is the right-option+q
"  nnoremap <buffer> œ :cprevious<CR>
"else
nnoremap <silent> <buffer> <M-i> <cmd>update <bar> Make<CR>
"endif
