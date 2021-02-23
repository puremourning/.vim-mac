if get( g:, 'vimspector_clean', 0 )
  finish
endif

scriptencoding utf-8

let g:vimspector_terminal_maxwidth = 85
let g:vimspector_bottombar_height = 15

function! s:SetUpUI() abort
  call win_gotoid( g:vimspector_session_windows.output )
  q
endfunction

augroup VimspectorCustom
  au!
  autocmd User VimspectorUICreated call s:SetUpUI()
augroup END

let g:vimspector_sign_priority = {
      \ 'vimspectorBP': 11,
      \ 'vimspectorBPCond': 11,
      \ 'vimspectorBPDisabled': 11,
      \ 'vimspectorPC': 12,
      \ }

" Custom mappings while debuggins {{{
let s:mapped = {}

function! s:OnJumpToFrame() abort
  if has_key( s:mapped, string( bufnr() ) )
    return
  endif

  nmap <silent> <buffer> <LocalLeader>d <Plug>VimspectorBalloonEval
  xmap <silent> <buffer> <LocalLeader>d <Plug>VimspectorBalloonEval

  let s:mapped[ string( bufnr() ) ] = 1
endfunction

function! s:OnDebugEnd() abort

  let original_buf = bufnr()
  let hidden = &hidden

  try
    set hidden
    for bufnr in keys( s:mapped )
      try
        execute 'noautocmd buffer' bufnr
        silent! nunmap <buffer> <LocalLeader>d
        silent! xunmap <buffer> <LocalLeader>d
      endtry
    endfor
  finally
    execute 'noautocmd buffer' original_buf
    let &hidden = hidden
  endtry

  let s:mapped = {}
endfunction

augroup VimspectorCustomMappings
  au!
  autocmd User VimspectorJumpedToFrame call s:OnJumpToFrame()
  autocmd User VimspectorDebugEnded call s:OnDebugEnd()
augroup END

" }}}
