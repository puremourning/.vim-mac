function! s:ShowGoToInPreviewWindow( result )
  if has_key( a:result, 'error' )
    echom a:result.error
    return
  endif

  if type( a:result ) == v:t_list
    echom 'Too many definitions'
    return
  endif

  execute 'pedit' '+' .. a:result.line_num a:result.filepath
endfunction

function! s:PreviewGoTo( cmd )
  call youcompleteme#GetRawCommandResponseAsync(
        \ function( 's:ShowGoToInPreviewWindow' ),
        \ a:cmd )
endfunction

nnoremap <silent> <plug>(YCMPEditDefinition)
      \ :<C-u>call <SID>PreviewGoTo( 'GoToDefinition' )<CR>
