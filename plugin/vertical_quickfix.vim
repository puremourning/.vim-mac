let cpo=&cpo
set cpo&vim

function! s:MakeVertical()
    let b:ycm_no_resize = 1
    wincmd L
endfunction

function! s:EnableVerticalQuickFix() abort
    augroup VerticalQuickFix
        au!
        autocmd FileType qf call s:MakeVertical()
    augroup END
endfunction

function! s:DisableVerticalQuickFix() abort
    au! VerticalQuickFix
endfunction

command! VerticalQuickFix call s:EnableVerticalQuickFix()
command! VerticalQuickFixDisable call s:DisableVerticalQuickFix()

let &cpo = cpo
