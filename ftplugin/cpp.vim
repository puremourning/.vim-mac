"if ! has( 'gui_running' )
"  " ƒ is right-option+b
"  nnoremap <buffer> ∫ :w<CR>:Make<CR>
"  " ∑ is the right-option+w
"  nnoremap <buffer> ∑ :cnext<CR>
"  " ∑ is the right-option+q
"  nnoremap <buffer> œ :cprevious<CR>
"else

function! s:Make()
  let dir = get( b:, 'make_dir', get( g:, 'make_dir', getcwd() ) )
  execute 'Make -j 10 -C' dir
endfunction

nnoremap <silent> <buffer> <M-i> <cmd>update <bar> call <SID>Make()<CR>
"endif
