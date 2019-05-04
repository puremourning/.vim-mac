if exists("current_compiler")
  finish
endif
let current_compiler = "vimspector_test"

setlocal errorformat=
        \Caught\ exception\ in\ %.%#\ @\ %f:%m,\ line\ %l

let &l:makeprg=fnamemodify( findfile( 'run_tests', '.;' ), ':p' )
            \ . ' $* 2>&1'

function! VimGetCurrentFunction()
  echom s:GetCurrentFunction()
endfunction

function! s:GetCurrentFunction()
  " Store the cursor position; we'll need to reset it
  let [ l:buf, l:row, l:col, l:offset ] = getpos( '.' )

  let l:test_function = ''

  let l:pattern = '\V\C\s\*function!\?\s\+\(\<\w\+\>\)\.\*\$'

  let l:lnum = prevnonblank( '.' )

  " Find the top-level method and class
  while l:lnum > 0
    call cursor( l:lnum, 1 )
    let l:lnum = search( l:pattern, 'bcnWz' )

    if l:lnum <= 0
      call cursor( l:row, l:col )
      return l:test_function
    endif

    let l:this_decl = substitute( getline( l:lnum ), l:pattern, '\1', '' )
    let l:this_decl_is_test = match( l:this_decl, '\V\C\^Test_' ) >= 0

    if l:this_decl_is_test
      let l:test_function = l:this_decl

      if indent( l:lnum ) == 0
        call cursor( l:row, l:col )
        return l:test_function
      endif
    endif

    let l:lnum = prevnonblank( l:lnum - 1 )
  endwhile

endfunction

function! s:RunTestUnderCursor()
  update
  let l:test_func_name = s:GetCurrentFunction()

  if l:test_func_name ==# ''
    echo "No test method found"
    return
  endif

  echo "Running test '" . l:test_func_name . "'"

  let l:test_arg = expand( '%:p:t' ) . ':' . l:test_func_name
  execute 'Make ' . l:test_arg
endfunction

function! s:RunTest()
  update
  Make %:p:t
endfunction

function! s:RunAllTests()
  update
  Make
endfunction

if ! has( 'gui_running' )
  " ® is right-option+r
  nnoremap <buffer> ® :call <SID>RunTest()<CR>
  " ® is right-option+r
  nnoremap <buffer> Â :call <SID>RunAllTests()<CR>
  " † is right-option+t
  nnoremap <buffer> † :call <SID>RunTestUnderCursor()<CR>
  " å is the right-option+q
  nnoremap <buffer> å :cfirst<CR>
  " å is the right-option+a
  nnoremap <buffer> œ :cnext<CR>
  " Ω is the right-option+z
  nnoremap <buffer> Ω :cprevious<CR>
endif
