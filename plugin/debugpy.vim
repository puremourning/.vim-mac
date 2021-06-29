function! s:Debugpy( ... ) abort
  py3 __import__( 'vimspector',
                \ fromlist=[ 'developer' ] ).developer.SetUpDebugpy(
                \    *vim.eval( '000' ) )
endfunction

command! -nargs=* Debugpy call s:Debugpy( <f-args> )
