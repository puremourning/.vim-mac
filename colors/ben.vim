" Vim color file
" Maintainer:	Thorsten Maerz <info@netztorte.de>
" Last Change:	2001 Jul 23
" grey on black
" optimized for TFT panels

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
"colorscheme default
let g:colors_name = "ben"

" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

set background=dark

hi Normal     guifg=white guibg=black
hi Type       term=bold ctermfg=Cyan guifg=#80a0ff 
hi Constant   term=underline ctermfg=Magenta guifg=#ffa0a0 
hi Statement  term=bold ctermfg=LightRed guifg=Red 
hi Identifier term=underline cterm=bold ctermfg=Cyan guifg=#40ffff 
hi Special    term=bold ctermfg=Yellow guifg=#ffff60 
hi PreProc    term=underline ctermfg=LightBlue guifg=#ff80ff
hi Comment    term=underline ctermfg=LightGreen guifg=#40b020
hi Error      term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White
hi Todo       term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
hi Folded     guibg=#000000 guifg=#ff80ff

hi link String        Constant
hi link Character     Constant
hi link Number        Constant
hi link Boolean       Constant
hi link Float         Number
hi link Function      Identifier
hi link Conditional   Statement
hi link Repeat        Statement
hi link Label         Statement
hi link Operator      Statement
hi link Keyword       Statement
hi link Exception     Statement
hi link Include       PreProc
hi link Define        PreProc
hi link Macro         PreProc
hi link PreCondit     PreProc
hi link StorageClass  Type
hi link Structure     Type
hi link Typedef       Type
hi link Tag           Special
hi link SpecialChar   Special
hi link Delimiter     Special
hi link SpecialComment Special
hi link Debug         Special

