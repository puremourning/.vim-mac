if exists("current_compiler")
  finish
endif
let current_compiler = "ycmd_test"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=%f:%l:%c:\ %t%s:\ %m
let &l:makeprg=fnamemodify( findfile( 'build.py', '.;' ), ':p' )
