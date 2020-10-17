function! s:Debugpy() abort
  py3 __import__( 'vimspector',
                \ fromlist=[ 'developer' ] ).developer.SetUpDebugpy()
endfunction

command! -nargs=0 Debugpy call s:Debugpy()
