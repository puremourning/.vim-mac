function! s:FindMakefile()
    let file_dir=expand('%:p:h')
    let mf = findfile('GNUmakefile', file_dir . ';')
    if empty(mf)
        let mf = findfile('Makefile', file_dir . ';')
    endif
    if !empty(mf)
        return fnamemodify(mf, ':p:h' )
    endif
    return getcwd()
endfunction

function! TbMake( ... )
  let dir = get( b:, 'make_dir', get( g:, 'make_dir' ) )
  if empty(dir)
      let dir=s:FindMakefile()
      let b:make_dir = dir
  endif
  execute 'Make -C' dir get( b:, 'make_args', '') join( a:000, ' ' )
endfunction

nnoremap <silent> <buffer> <M-i> <cmd>update <bar> call TbMake('RECURSIVE=NO')<CR>
nnoremap <silent> <buffer> <leader><M-i> <cmd>update <bar> call TbMake()<CR>

" tbricks team like to double-indent after line ending with (
" e.g.
"
" foo_long_line_bar_baz_boop(
"         bar,
"         baz)
"
" rather than the far superior:
"
" foo_long_line_bar_baz_boop(
"     bar,
"     baz)
setlocal cinoptions+=W2s
