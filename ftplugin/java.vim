" Enable javacomplete if eclim is disabled
"
" TODO: or.. eclim is not running
if get(g:, 'EclimDisabled', 0)
    set omnifunc=javacomplete#Complete
endif
