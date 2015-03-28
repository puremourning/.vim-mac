" Vim color file
" Maintainer:	Thorsten Maerz <info@netztorte.de>
" Last Change:	2001 Jul 23
" grey on black
" optimized for TFT panels

hi clear

if exists("syntax_on")
  syntax reset
endif

set background=dark
let g:colors_name = "ben"

" imported from macvim
hi DiffAdd      guibg=MediumSeaGreen
hi Directory    guifg=#1600FF
hi ErrorMsg     guibg=Firebrick2 guifg=White
hi FoldColumn   guibg=Grey guifg=DarkBlue
hi Folded       guibg=#E6E6E6 guifg=DarkBlue
hi IncSearch    gui=reverse
hi ModeMsg      gui=bold
hi MoreMsg      gui=bold guifg=SeaGreen4
hi NonText      gui=bold guifg=Blue
hi Pmenu        guibg=LightSteelBlue1
hi PmenuSbar    guibg=Grey
hi PmenuSel     guifg=White guibg=SkyBlue4
hi PmenuThumb   gui=reverse
hi Question     gui=bold guifg=Chartreuse4
hi SignColumn   guibg=Grey guifg=DarkBlue
hi SpecialKey   guifg=Blue
hi SpellBad     guisp=Firebrick2 gui=undercurl
hi SpellCap     guisp=Blue gui=undercurl
hi SpellLocal   guisp=DarkCyan gui=undercurl
hi SpellRare    guisp=Magenta gui=undercurl
hi StatusLine   gui=NONE guifg=White guibg=DarkSlateGray
hi StatusLineNC gui=NONE guifg=SlateGray guibg=Gray90
hi TabLine      gui=underline guibg=LightGrey
hi TabLineFill  gui=reverse
hi TabLineSel   gui=bold
hi Title        gui=bold guifg=DeepSkyBlue3
hi VertSplit    gui=NONE guifg=DarkSlateGray guibg=Gray90
if has("gui_macvim")
  hi Visual       guibg=MacSelectedTextBackgroundColor
else
  hi Visual       guibg=#72F7FF
endif
hi WarningMsg   guifg=Firebrick2

" Syntax items (`:he group-name` -- more groups are available, these are just
" the top level syntax items for now).
hi Error        gui=NONE guifg=White guibg=Firebrick3
hi Identifier   gui=NONE guifg=Aquamarine4 guibg=NONE
hi Ignore       gui=NONE guifg=bg guibg=NONE
hi PreProc      gui=NONE guifg=DodgerBlue3 guibg=NONE
hi Special      gui=NONE guifg=BlueViolet guibg=NONE
hi String       gui=NONE guifg=SkyBlue4 guibg=NONE
hi Underlined   gui=underline guifg=SteelBlue1
hi Boolean      gui=NONE guifg=DeepPink4 guibg=NONE
hi Comment      gui=italic guifg=CadetBlue3
hi Constant     gui=NONE guifg=Goldenrod1 guibg=NONE
hi Cursor       guibg=LightGoldenrod guifg=bg
hi CursorColumn guibg=Gray20
hi CursorIM     guibg=LightSlateGrey guifg=bg
hi CursorLine   guibg=Gray20
hi DiffChange   guibg=MediumPurple4
hi DiffDelete   gui=bold guifg=White guibg=SlateBlue
hi DiffText     gui=NONE guifg=White guibg=SteelBlue
hi LineNr       guifg=#552A7B guibg=Grey5
hi MatchParen   guifg=White guibg=Magenta
hi Normal       guifg=Grey50 guibg=Grey10
hi Search       guibg=Blue4 guifg=NONE
hi Statement    gui=bold guifg=Purple1 guibg=NONE
hi Todo         gui=NONE guifg=Green4 guibg=DeepSkyBlue1
hi Type         gui=bold guifg=Cyan4 guibg=NONE
hi WildMenu     guibg=SkyBlue guifg=White
hi lCursor      guibg=LightSlateGrey guifg=bg


" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

hi Type     term=bold ctermfg=Cyan guifg=#80a0ff guibg=black
hi Constant term=underline ctermfg=Magenta guifg=#ffa0a0 guibg=black
hi Statement        term=bold ctermfg=LightRed guifg=Red guibg=black
hi Identifier term=underline cterm=bold ctermfg=Cyan guifg=#40ffff guibg=black
hi Special term=bold ctermfg=Yellow guifg=#ffff60 guibg=black
hi PreProc  term=underline ctermfg=LightBlue guifg=#ff80ff guibg=black
hi Comment  term=underline ctermfg=LightGreen guifg=#40b020 guibg=black
hi Error      term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White
hi Todo       term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
hi Folded guibg=#000000 guifg=#ff80ff guibg=black

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

