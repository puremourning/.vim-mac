function! PythonGetCurrentFunction()
  echom s:GetCurrentFunction()
endfunction

function! s:MakeMethodName( cls, mth )
  if a:cls != ''
    if a:mth != ''
      return a:cls . '.' . a:mth
    else
      return a:cls
    endif
  endif
  return a:mth
endfunction

function! s:GetCurrentFunction()
  " Store the cursor position; we'll need to reset it
  let [ l:buf, l:row, l:col, l:offset ] = getpos( '.' )

  let l:test_method = ''
  let l:test_class = ''

  let l:pattern = '\V\C\s\*\<\%(def\|class\)\>\s\+\(\<\w\+\>\)\w\*(\.\*\$'

  let l:lnum = prevnonblank( '.' )

  " Find the top-level method and class
  while l:lnum > 0
    call cursor( l:lnum, 1 )
    let l:lnum = search( l:pattern, 'bcnWz' )

    if l:lnum <= 0
      call cursor( l:row, l:col )
      return s:MakeMethodName( l:test_class, l:test_method )
    endif

    " FIXME: This is about as inefficient as it could be
    let l:this_decl = substitute( getline( l:lnum ), l:pattern, '\1', '' )
    let l:this_decl_is_test = match( l:this_decl, '\V\C_test\$' ) >= 0
    let l:this_decl_is_method = match( getline( l:lnum ), '\V\C\s\*def') >= 0
    let l:this_decl_is_class = match( getline( l:lnum ), '\V\C\s\*class') >= 0

    if l:this_decl_is_test
      if l:this_decl_is_method
        if l:test_method == ''
          let l:test_method = l:this_decl
        endif
      elseif l:this_decl_is_class
        if l:test_class == ''
          let l:test_class = l:this_decl
        endif
      endif

      if indent( l:lnum ) == 0
        call cursor( l:row, l:col )
        return s:MakeMethodName( l:test_class, l:test_method )
      endif
    endif

    let l:lnum = prevnonblank( l:lnum - 1 )
  endwhile

endfunction

function! s:RunTestUnderCursor()
  compiler ycmd_test
  update
  let l:test_func_name = s:GetCurrentFunction()

  if l:test_func_name ==# ''
    echo "No test method found"
    return
  endif

  echo "Running test '" . l:test_func_name . "'"

  let l:test_arg = expand( '%:p' ) . '::' . l:test_func_name
  execute 'Make --skip-build --no-flake8 -- ' . l:test_arg
endfunction

function! s:RunTest()
  compiler ycmd_test
  update
  Make --no-flake8 --skip-build -- %:p
endfunction

function! s:RunTestUnderCursorInVimspector()
  compiler ycmd_test
  update
  let l:test_func_name = s:GetCurrentFunction()

  if l:test_func_name ==# ''
    echo "No test method found"
    return
  endif

  let l:test_arg = expand( '%:p' ) . '::' . l:test_func_name
  echom "Running test '" . l:test_arg . "'"


  " TODO: Do we need the file name here ?
  " call vimspector#AddFunctionBreakpoint( l:test_func_name )
  " HACK: NO IDEA WHY THIS IS NEEDED
  call vimspector#internal#state#Reset()
  call vimspector#ToggleBreakpoint()
  call vimspector#LaunchWithSettings( { 'Test': l:test_arg } )
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
  nnoremap <buffer> ® :call <SID>RunTest()<CR>
  " ® is right-option+r
  nnoremap <buffer> Â :call <SID>RunAllTests()<CR>
  " † is right-option+t
  nnoremap <buffer> † :call <SID>RunTestUnderCursor()<CR>
  " † is right-option+t
  nnoremap <buffer> <leader>† :call <SID>RunTestUnderCursorInVimspector()<CR>
  " ƒ is right-option+b
  nnoremap <buffer> ∫ :call <SID>Build()<CR>
  " å is the right-option+q
  nnoremap <buffer> å :cfirst<CR>
  " å is the right-option+a
  nnoremap <buffer> œ :cnext<CR>
  " Ω is the right-option+z
  nnoremap <buffer> Ω :cprevious<CR>
endif
