if exists("current_compiler")
  finish
endif
runtime compiler/tbmake.vim
let current_compiler = "tbmaketest"

let s:cpo_save = &cpo
set cpo&vim

let b:make_args='TESTS=FORCE MVN_SKIP=YES'

function! s:GetTestUnderCursor()
    " Parse the test macros to find the nearest
    "
    " TEST(Fixture, TestName)
    " TEST_F(ClassName, TestName),
    " TEST_P(SuiteName, TestName)
    "
    let [ buf, row, col, offset ] = getpos( '.' )
    let [ test_function, test_function_line ] = [ v:null, -1 ]

    let pattern = '\V\C\s\*TEST\%\(_\[PF]\)\?(\s\*\(\[^,]\+\)\s\*,\s\*\(\[^)]\+\)\s\*)'
    let lnum = prevnonblank( '.' )
    while lnum > 0
        call cursor( lnum, 1 )
        let lnum = search( pattern, 'bcnWz' )

        if lnum <= 0
            call cursor( row, col )
            return [ test_function, test_function_line ]
        endif

        let matches = matchlist( getline( lnum ), pattern )
        if len( matches ) < 3
            let lnum = prevnonblank( lnum - 1 )
            continue
        endif

        let [ fixture, name ] = [ matches[1], matches[2] ]
        let test_function = '*' .. fixture .. '*.*' .. name .. '*'
        let test_line = lnum
        return [ test_function, test_line ]
    endwhile
endfunction

function! s:RunTestUnderCursor()
    let [ test, line ] = s:GetTestUnderCursor()
    call TbMake( 'RECURSIVE=NO TESTS=FORCE GTEST_FILTER=' . test )
endfunction

function! s:RunTestUnderCursorInVimspector()
    let [ test, line ] = s:GetTestUnderCursor()
    call TbMake( 'RECURSIVE=NO TESTS=YES MK_RUN_PROGRAM=NO' )
    call vimspector#LaunchWithSettings( #{
                \ configuration: 'Local gTest',
                \ gtest_filter: test,
                \ } )
endfunction

nnoremap <silent> <buffer> <M-I> <cmd>call <SID>RunTestUnderCursor()<CR>
nnoremap <silent> <buffer> <M-P> <cmd>cfirst<CR>
nnoremap <silent> <buffer> <M-}> <cmd>cnext<CR>
nnoremap <silent> <buffer> <M-{> <cmd>cprevious<CR>

nnoremap <silent> <buffer> <M-O> <cmd>call <SID>RunTestUnderCursorInVimspector()<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
