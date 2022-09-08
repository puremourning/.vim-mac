if get( g:, 'vimspector_clean', 0 )
  finish
endif

scriptencoding utf-8

let g:vimspector_terminal_maxwidth = 85
let g:vimspector_bottombar_height = 15

function! s:SetUpUI() abort
  call win_gotoid( g:vimspector_session_windows.output )
  q

  call win_gotoid( g:vimspector_session_windows.variables )
  nmap <silent> <buffer> <LocalLeader>d <Plug>VimspectorBalloonEval
  xmap <silent> <buffer> <LocalLeader>d <Plug>VimspectorBalloonEval

  call win_gotoid( g:vimspector_session_windows.watches )
  nmap <silent> <buffer> <LocalLeader>d <Plug>VimspectorBalloonEval
  xmap <silent> <buffer> <LocalLeader>d <Plug>VimspectorBalloonEval

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

  nmap <silent> <buffer> <LocalLeader>c <Plug>VimspectorContinue
  nmap <silent> <buffer> <LocalLeader><LocalLeader> <Plug>VimspectorStopOver
  nmap <silent> <buffer> <LocalLeader>n <Plug>VimspectorStepOver
  nmap <silent> <buffer> <LocalLeader>s <Plug>VimspectorStepInto
  nmap <silent> <buffer> <LocalLeader>f <Plug>VimspectorStepOut
  nmap <silent> <buffer> <LocalLeader>g <Plug>VimspectorGoToCurrentLine

  nmap <silent> <buffer> <LocalLeader>k <Plug>VimspectorUpFrame
  nmap <silent> <buffer> <LocalLeader>j <Plug>VimspectorDownFrame

  let s:mapped[ string( bufnr() ) ] = &l:modifiable
  setlocal nomodifiable
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

        silent! nunmap <buffer> <LocalLeader>c
        silent! nunmap <buffer> <LocalLeader><LocalLeader>
        silent! nunmap <buffer> <LocalLeader>n
        silent! nunmap <buffer> <LocalLeader>s
        silent! nunmap <buffer> <LocalLeader>f

        silent! nunmap <buffer> <LocalLeader>k
        silent! nunmap <buffer> <LocalLeader>j

        let &l:modifiable = s:mapped[ bufnr ]
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
  autocmd SessionLoadPost * silent! VimspectorLoadSession
  autocmd User VimspectorJumpedToFrame call s:OnJumpToFrame()
  autocmd User VimspectorDebugEnded call s:OnDebugEnd()
augroup END

nmap <LocalLeader>B <Plug>VimspectorBreakpoints

let g:vimspector_custom_process_picker = expand( '<SID>' ) . 'PickProcess()'

function! s:PickProcess() abort
  return str2nr(split(fzf#run({'source': 'ps -e'})[0])[0])
endfunction


" }}}
