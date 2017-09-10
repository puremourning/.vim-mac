function! s:RunTest()
  compiler ycmd_test
  update
  Make --skip-build -- %:p
endfunction

function! s:RunAllTests()
  compiler ycmd_test
  update
  Make --skip-build
endfunction

function! s:Build()
  compiler ycmd_build
  Make --all
endfunction

if ! has( 'gui_running' )
  " ® is right-option+r
  nnoremap ® :call <SID>RunTest()<CR>
  " ® is right-option+shift+r
  nnoremap Â :call <SID>RunAllTests()<CR>
  " ƒ is right-option+b
  nnoremap ∫ :call <SID>Build()<CR>
  " å is the right-option+q
  nnoremap å :cfirst<CR>
  " å is the right-option+a
  nnoremap œ :cnext<CR>
  " Ω is the right-option+z
  nnoremap Ω :cprevious<CR>
endif
