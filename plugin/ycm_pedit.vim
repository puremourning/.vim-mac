function! s:ShowGoToInPreviewWindow( result ) abort
  if type( a:result ) == v:t_none || empty( a:result )
    return
  endif

  if type( a:result ) == v:t_dict && has_key( a:result, 'error' )
    echom a:result.error
    return
  endif

  if type( a:result ) == v:t_list
    echom 'Too many definitions'
    return
  endif

  execute 'pedit' '+' .. a:result.line_num a:result.filepath
endfunction

function! s:PreviewGoTo( cmd ) abort
  call youcompleteme#GetRawCommandResponseAsync(
        \ function( 's:ShowGoToInPreviewWindow' ),
        \ a:cmd )
endfunction

nnoremap <silent> <plug>(YCMPEditDefinition)
      \ :<C-u>call <SID>PreviewGoTo( 'GoToDefinition' )<CR>
