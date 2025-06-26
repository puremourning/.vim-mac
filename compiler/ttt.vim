" Vim compiler hile
" Compiler: Unit testing for Python using nose
" Maintainer: Olivier Le Thanh Duong <olivier@lethanh.be>
" Last Change: 2010 Sep 1

" Based on pyunit.vim distributed with vim
" Compiler: Unit testing tool for Python
" Maintainer: Max Ischenko <mfi@ukr.net>
" Last Change: 2004 Mar 27
"
" Modified by lambdalisue
" Last Change: 2011 Dec 12

if exists("current_compiler")
  finish
endif
let current_compiler = "ttt"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" CompilerSet errorformat=
"       \%C\ %.%#,
"       \%A\ \ File\ \"%f\"\\,
"       \\ line\ %l%.%#,
"       \%Z%[%^\ ]%\\@=%m


CompilerSet errorformat=
      \%EE\ \ \ \ \ File\ \"%f\"\\,\ line\ %l,
      \%CE\ \ \ %p^,
      \%ZE\ \ \ %[%^\ ]%\\@=%m,
      \%Afile\ %f\\,\ line\ %l,
      \%+ZE\ %mnot\ found,
      \%CE\ %.%#,
      \%A_%\\+\ %o\ _%\\+,
      \%C%f:%l:\ in\ %o,
      \%ZE\ %\\{3}%m,
      \%EImportError%.%#\'%f\'\.,
      \%C%.%#,

let &l:makeprg=fnamemodify( findfile( 'pytest.ini', '.;' ), ':p:h' )
      \ . '/bin/ttt exec python3 -m pytest -s --tb=short $*'

if has( 'win32' ) && ! has( 'win32unix' )
  let &l:makeprg='python ' . &l:makeprg
else
  let &l:makeprg.=' 2>&1'
endif

let $YCM_TEST_RETRY_TIMEOUT = 5
let $YCM_TEST_NO_RETRY = 1

