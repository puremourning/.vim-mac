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
