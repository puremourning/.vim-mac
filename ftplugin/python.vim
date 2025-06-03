function! PythonGetCurrentFunction()
  echom s:GetCurrentModule() . '.' . s:GetCurrentFunction()
endfunction

function! s:WorkspaceRelativePath(path)
    let workspace_root = fnamemodify(findfile('pytest.ini', '.;'), ':p:h')
    let cwd = getcwd()
    try
       call chdir(workspace_root)
       return fnamemodify(a:path, ':p:~:.')
    finally
        call chdir(cwd)
    endtry
    return a:path
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

function! s:GetCurrentModule()
  let cwd = expand( '%:p:h' )
  " Take the file_name from /path/to/file_name.py
  let mod = [ expand( '%:p:t:r' ) ]
  while filereadable( cwd . '/__init__.py' )
    " Add the current_path from /path/current_path/to/file_name.py
    call add( mod, fnamemodify( cwd, ':t' ) )
    let cwd = fnamemodify( cwd, ':h' )
  endwhile

  return join( reverse( mod ), '.' )
endfunction

function! s:GetCurrentFunction()
  " Store the cursor position; we'll need to reset it
  let [ l:buf, l:row, l:col, l:offset ] = getpos( '.' )

  let l:test_method = ''
  let l:test_class = ''

  let l:pattern = '\V\C\s\*\<\%(def\|class\|async\s\+def\)\>\s\+\(\<\w\+\>\)\w\*(\.\*\$'

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
    let l:this_decl_is_method = match( getline( l:lnum ), '\V\C\s\*def') >= 0 ||
                \ match( getline( l:lnum ), '\V\C\s\*async\s\+def')
    let l:this_decl_is_class = match( getline( l:lnum ), '\V\C\s\*class') >= 0

    if l:this_decl_is_method
      let l:this_decl_is_test = match( l:this_decl, '\V\C\^test_' ) >= 0
    elseif l:this_decl_is_class
      let l:this_decl_is_test = match( l:this_decl, '\V\CTest\$' ) >= 0
    else
      let l:this_decl_is_test = v:false
    endif

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

  call cursor( l:row, l:col )
endfunction

function! s:RunTestUnderCursor()
  compiler ttt
  update
  let l:test_func_name = s:GetCurrentFunction()

  if l:test_func_name ==# ''
    echo "No test method found"
    return
  endif

  echo "Running test '" . l:test_func_name . "'"

  let l:test_arg = s:WorkspaceRelativePath(expand('%:p')) . ' -k ' . l:test_func_name
  execute 'Make ' . l:test_arg
endfunction

function! s:RunTest()
  compiler ttt
  update
  execute 'Make ' s:WorkspaceRelativePath(expand('%:p'))
endfunction

function! s:RunTestUnderCursorInVimspector()
  compiler ttt
  update
  let l:test_func_name = s:GetCurrentFunction()

  if l:test_func_name ==# ''
    echo "No test method found"
    return
  endif

  let l:test_arg = s:WorkspaceRelativePath(expand('%:p')) . ' -k ' . l:test_func_name
  echom "Running test '" . l:test_arg . "'"


  call vimspector#ToggleBreakpoint()
  call vimspector#LaunchWithSettings( { 'args': l:test_arg } )
endfunction

function! s:RunAllTests()
  compiler ttt
  update
  Make
endfunction

if ! has( 'gui_running' )
  " ® is right-option+r
  nnoremap <buffer> <M-o> :call <SID>RunTest()<CR>
  " ® is right-option+r
  nnoremap <buffer> <leader><M-o> :call <SID>RunAllTests()<CR>
  " † is right-option+t
  nnoremap <buffer> <M-p> :call <SID>RunTestUnderCursor()<CR>
  " † is right-option+t
  nnoremap <buffer> <leader><M-p> :call <SID>RunTestUnderCursorInVimspector()<CR>
  " å is the right-option+q
  nnoremap <buffer> <M-M> :cfirst<CR>
  " å is the right-option+a
  nnoremap <buffer> <M-[> :cnext<CR>
  " Ω is the right-option+z
  nnoremap <buffer> <M-]> :cprevious<CR>
endif
