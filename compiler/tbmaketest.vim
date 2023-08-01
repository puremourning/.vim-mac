if exists("current_compiler")
  finish
endif
runtime compiler/tbmake.vim
let current_compiler = "tbmaketest"

let s:cpo_save = &cpo
set cpo&vim

let b:make_args='TESTS=YES MVN_SKIP=YES'

let &cpo = s:cpo_save
unlet s:cpo_save
