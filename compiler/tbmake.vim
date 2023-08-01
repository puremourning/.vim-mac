if exists("current_compiler")
  finish
endif
runtime compiler/gcc.vim
let current_compiler = "tbmake"

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=tbmake\ -j
let b:make_args='TESTS=YES MVN_SKIP=YES'

let &cpo = s:cpo_save
unlet s:cpo_save
