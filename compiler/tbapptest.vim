if exists("current_compiler")
  finish
endif
runtime compiler/gcc.vim
let current_compiler = "tbapptest"

let s:cpo_save = &cpo
set cpo&vim

" We can't use -s because Vim needs the enter/leave directory messages
CompilerSet makeprg=gmake\ -w\ -j\ 16\ test\ PRINT_RUN_ERRORS=YES

let b:make_args=get(b:,
                  \ 'make_args',
                  \ get(g:, 'make_args', ''))

CompilerSet errorformat+=%DErrors\ in\ test\ in\ '%f'
CompilerSet errorformat+=%XEnd\ of\ errors
CompilerSet errorformat+=Immediate\ stop:\ Error\ at\ %f\(%l\):\ %m

let &cpo = s:cpo_save
unlet s:cpo_save
