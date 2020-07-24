scriptencoding utf-8

sign define vimspectorBP text=●         texthl=WarningMsg
sign define vimspectorBPCond text=◼     texthl=WarningMsg
sign define vimspectorBPDisabled text=○ texthl=LineNr
sign define vimspectorPC text=▶         texthl=MatchParen

let g:vimspector_terminal_maxwidth = 85
let g:vimspector_bottombar_height = 15

function! s:SetUpUI() abort
  call win_gotoid( g:vimspector_session_windows.output )
  q

  call win_gotoid( g:vimspector_session_windows.code )
  nunmenu WinBar
  nnoremenu WinBar.■\ Stop :call vimspector#Stop()<CR>
  nnoremenu WinBar.▶\ Continue :call vimspector#Continue()<CR>
  nnoremenu WinBar.▷\ Pause :call vimspector#Pause()<CR>
  nnoremenu WinBar.↷\ Next :call vimspector#StepOver()<CR>
  nnoremenu WinBar.→\ Step :call vimspector#StepInto()<CR>
  nnoremenu WinBar.←\ Finish :call vimspector#StepOut()<CR>
  nnoremenu WinBar.⟲: :call vimspector#Restart()<CR>
  nnoremenu WinBar.✕ :call vimspector#Reset()<CR>
endfunction

augroup VimspectorCustom
  au!
  autocmd User VimspectorUICreated call s:SetUpUI()
augroup END
