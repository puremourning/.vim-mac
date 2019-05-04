if exists("current_compiler")
  finish
endif
let current_compiler = "vim_test"

setlocal errorformat=Found\ Errors\ in\ %m

func s:RunTest()
  update
  Make -C %:h -B %:t:r
endfunc

func s:RunAllTests( force )
  update
  if a:force
    Make -C %:h clean
  endif

  Make test
endfunc

func s:RunTestUnderCursor()
  call s:RunTest()
endfunc

func s:RunTestUnderCursorInVimspector()
  call vimspector#internal#state#Reset()
  call vimspector#LaunchWithSettings( { 'Test': expand( '%:t:r' ) } )
endfunc

func s:Build()
  update
  Make -j 8
endfunc

if ! has( 'gui_running' )
  " ® is right-option+r
  nnoremap <buffer> ® :call <SID>RunTestUnderCursorInVimspector()<CR>
  " Â is right-option+R
  nnoremap <buffer> Â :call <SID>RunAllTests( 0 )<CR>
  " † is right-option+t
  nnoremap <buffer> † :call <SID>RunTest()<CR>
  " Ê is right-option+T
  nnoremap <buffer> Ê :call <SID>RunAllTests( 1 )<CR>
  " ∫ is right-option+b
  nnoremap <buffer> ∫ :call <SID>Build()<CR>
  " å is the right-option+q
  nnoremap <buffer> å :cfirst<CR>
  " å is the right-option+a
  nnoremap <buffer> œ :cnext<CR>
  " Ω is the right-option+z
  nnoremap <buffer> Ω :cprevious<CR>
endif
