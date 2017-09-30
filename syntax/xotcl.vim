" Vim syntax file
" Language:	XOTcl
" Maintainer:	Ben Jackson <puremourning@icloud.com)
" Original:	Ben Jackson <puremourning@icloud.com)
" Last Change:	2016-08-19
" Version:	0.1
" URL:		NONE

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Inherit tcl syntax
runtime! syntax/tcl.vim

" TODO: Change to use a region, containing a set of keywords for Class ensemble
syn keyword xotclClassDefn Class -superclass -parameter create

syn keyword xotclProcDefn  instproc
syn keyword xotclVarDefn   instvar

syn match xotclAtObjectSingle "^\w*@[^$]*$"

" We need to match:
"  @ stuff stuff stuff { }
"  @ stuff stuff stuff {
"      ... any other stuff, including {
"          extra scopes, etc.
"      }
"  }
"
" To acheive this we define a region matching "@...{ ... }" and a contained
" region matching any nested "{...}". Unintuitively, the latter must include a
" negation of the former, as otherwise the latter matches the "{" of the
" signpost too, so we just want it to match any *nested* scopes
"
" TODO: There is some suggestion that matchgroup and matchstart and matchend can
" be used to fix this properly

syn region xotclAtObjectBody start="\(^\w*@[^$]*\)\@<!{" end="}"
      \ transparent contained
      \ contains=xotclAtObjectBody

syn region xotclAtObject start="^\w*@[^$]*{" end="}"
      \ contains=xotclAtObjectBody

if version >= 508 || !exists("did_xotcl_syntax_inits")
  if version < 508
    let did_xotcl_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink xotclClassDefn Type
  HiLink xotclProcDefn  Type
  HiLink xotclVarDefn   Type

  HiLink xotclAtObjectSingle Comment
  HiLink xotclAtObject       Comment

  delcommand HiLink
endif

let b:current_syntax = "xotcl"
