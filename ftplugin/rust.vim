if ! has( 'gui_running' )
  " ® is right-option+r
  nnoremap ® :update<CR>:Make run<CR>
  " ƒ is right-option+r
  nnoremap ∫ :update<CR>:Make build<CR>
  " å is the right-option+a
  nnoremap å :cnext<CR>
else
  nnoremap <M-r> :w<CR>:Make run<CR>
  nnoremap <M-b> :w<CR>:Make build<CR>
  nnoremap <M-a> :cnext<CR>
endif

" TODO: Check for a Cargo.toml ?
compiler cargo
