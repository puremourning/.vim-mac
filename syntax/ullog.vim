if exists("b:current_syntax")
  finish
endif

syn keyword ulLogLevelInfo      INFO
syn keyword ulLogLevelDebug     DEBUG
syn keyword ulLogLevelWarn      WARNING
syn keyword ulLogLevelError     ERROR
syn keyword ulLogLevelCritical  CRITICAL

" syn match ulLogTag   "[0-9A-Z.[\]#]\+="me=e-1
" syn match ulLogValue "=[^|]\+|"ms=s+1,me=e-1

syn match ulLogTag       "[^ ]\+=[^|]\+|"          contains=ulLogTagName,ulLogTagValue,ulLogTagSep transparent
syn match ulLogTagName   "[0-9a-zA-Z.[\]#!]\+\ze="    contained contains=ulLogTagMsgType,ulLogTagText
syn match ulLogTagValue  "=[^|]\+|"ms=s+1,me=e-1   contained
syn match ulLogTagSep    "|"                       contained

" Specific tags of particular interest highlighted
syn keyword ulLogTagMsgType 35 MSGTYPE                contained
syn keyword ulLogTagText    58 TEXT                   contained

" TODO : syn region ulLogXML ...
" TODO : syn match comma-separated version of ulLogTag
" TODO : syn region ulLogJSON

" Match lines that look like java exception traces like this:
" com.ullink.....: Some message caught here: class(file:line) ...
syn match ulLogExceptionMsg "\(com\|java\|net\|io\|org\)\.[a-zA-Z0-9_.]\+\.\zs[A-Za-z0-9_]*Exception:.*\zecaught here:"

syn match ulLogExceptionTrace "caught here:\zs.*\ze$" contains=ulLogExceptionFileLine,ulLogExceptionClassName
syn match ulLogExceptionFileLine "(\zs[^:)]*\(:[0-9]*\)\?\ze)" contained

hi default link ulLogExceptionMsg WarningMsg
hi default link ulLogExceptionFileLine String





syn match ulLogTimestamp "^[0-9\-]\{10} [0-9:._]\{16}\ze "
syn match ulLogAttr      "\[[^\]]\+\]"hs=s+1,he=e-1 contains=ulLogTag

hi default link ulLogLevelInfo     Comment
hi default link ulLogLevelDebug    Debug
hi default link ulLogLevelWarn     WarningMsg
hi default link ulLogLevelError    ErrorMsg
hi default link ulLogLevelCritical DiffDelete

hi default link ulLogTagName    Tag
hi default link ulLogTagValue   String
hi default link ulLogTagSep     NonText
hi default link ulLogTagEq      Operator
hi default link ulLogTagMsgType Identifier
hi default link ulLogTagText    Identifier

hi default link ulLogTimestamp  Number
hi default link ulLogAttr       Function

let b:current_syntax = "ullog"
