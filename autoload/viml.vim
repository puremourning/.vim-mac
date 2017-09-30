"let s:save_cpo = &cpo
"set cpo&vim
"
"function! viml#Complete( findstart, base )
"  if a:findstart
"    echom '- get_complete_position -'
"    echom 'line: ' . getline( '.' )
"    echom 'col: ' . col( '.' )
"    let input=getline( '.' )[ : col( '.' ) ]
"    echom 'input: ' . input
"    let pos=necovim#get_complete_position( input ) + 1
"    echom 'pos = ' . pos
"    return pos
"  else
"    echom '- gather_candidates -'
"    echom 'base: ' . a:base
"    echom 'line: ' . getline( '.' ) . a:base
"    return necovim#gather_candidates( getline( '.' ) . a:base, a:base )
"  endif
"endfunction
"
"let g:test = {
"      \ 'test': 1,
"      \ 'key': 100
"      \ }
"
"function! s:test()
"  call nnecovim#helper#var(
"endfunction
"
"let &cpo = s:save_cpo
"unlet s:save_cpo
