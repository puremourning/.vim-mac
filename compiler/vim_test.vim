if exists("current_compiler")
  finish
endif
let current_compiler = "vim_test"

setlocal errorformat=Found\ Errors\ in\ %m,Caught\ exception:
setlocal makeprg=make

func! s:RunTest() abort
  update
  Make -C %:h -B %:t:r
endfunc

func! s:RunAllTests( force ) abort
  update
  if a:force
    Make -C %:h clean
  endif

  Make test
endfunc


function! s:GetCurrentFunction()
  " Store the cursor position; we'll need to reset it
  let [ buf, row, col, offset ] = getpos( '.' )

  let [ test_function, test_function_line ] = [ v:null, -1 ]

  let pattern = '\V\C\s\*\%\(func\%\(tion\)\|def\)\?!\?\s\+\(\<\w\+\>\)\.\*\$'

  let lnum = prevnonblank( '.' )

  " Find the top-level method and class
  while lnum > 0
    call cursor( lnum, 1 )
    let lnum = search( pattern, 'bcnWz' )

    if lnum <= 0
      call cursor( row, col )
      return [ test_function, test_function_line ]
    endif

    let this_decl = substitute( getline( lnum ), pattern, '\1', '' )
    let this_decl_is_test = match( this_decl, '\V\C\^Test_' ) >= 0

    if this_decl_is_test
      let [ test_function, test_function_line ] = [ this_decl, lnum ]

      if indent( lnum ) == 0
        call cursor( row, col )
        return [ test_function, test_function_line ]
      endif
    endif

    let lnum = prevnonblank( lnum - 1 )
  endwhile

  return [ v:null, -1 ]
endfunction

func! s:RunTestUnderCursor() abort
  let func = s:GetCurrentFunction()[ 0 ]
  if func is v:null
    echom "No test found"
    return
  endif

  let $TEST_FILTER=func
  call s:RunTest()
  unlet $TEST_FILTER
endfunc

func! s:RunTestUnderCursorInVimspector() abort
  call vimspector#internal#state#Reset()
  let opts = #{ Test: expand( '%:t:r' ) }
  let func = s:GetCurrentFunction()[ 0 ]
  if func isnot v:null
    call extend( opts, #{ Filter: func } )
  endif
  call vimspector#LaunchWithSettings( opts )
endfunc

func! s:Build() abort
  update
  Make -j 8
endfunc

if ! has( 'gui_running' )

  " ® is right-option+r
  nnoremap <buffer> ® :call <SID>RunTest()<CR>
  " Â is right-option+R
  nnoremap <buffer> Â :call <SID>RunAllTests()<CR>
  " † is right-option+t
  nnoremap <buffer> † :call <SID>RunTestUnderCursor()<CR>
  " Ê is right-option+T
  nnoremap <buffer> Ê :call <SID>RunTestUnderCursorInVimspector()<CR>
  " å is the right-option+q
  nnoremap <buffer> å :cfirst<CR>
  " Œ is the right-option+shift-q
  nnoremap <buffer> Œ :cfirst<CR>
  " å is the right-option+a
  nnoremap <buffer> œ :FuncLine<CR>
  " Ω is the right-option+z
  nnoremap <buffer> Ω :cprevious<CR>
endif

function! s:GoToCurrentFunctionLine( ... )
  if a:0 < 1
    call inputsave()
    let lnum = str2nr( input( 'Enter line num: ' ) )
    call inputrestore()
  else
    let lnum = a:1
  endif

  let [ f, l ] = s:GetCurrentFunction()
  if f is v:null
    return
  endif

  let lnum += l

  echo 'Function' f 'at line' l '(jump to line ' lnum . ')'

  call cursor( [ lnum, indent( lnum ) ] )
endfunction

command! -buffer -nargs=? -bar
      \ FuncLine
      \ :call s:GoToCurrentFunctionLine( <f-args> )
