" Basic plugin boilerplate

let s:cpo = &cpoptions
set cpoptions&vim

function! s:RefreshTail(win_id)
    call win_execute(a:win_id, 'setlocal autoread', 'silent!')
    call win_execute(a:win_id, 'checktime', 'silent!')
    call win_execute(a:win_id, 'normal! G', 'silent!')
endfunction

function! s:EnableTailing()
    let win_id = win_getid()
    call s:RefreshTail(win_id)

    let b:tail_timer = timer_start(500, {-> s:RefreshTail(win_id)}, {'repeat': -1})

    execute 'autocmd WinClosed '
                \ .. win_id
                \ .. ' call win_execute(' .. win_id .. ', "call <SID>DisableTailing()")'
    normal G
endfunction

function! s:DisableTailing()
    setlocal noautoread
    if exists('b:tail_timer')
        call timer_stop(b:tail_timer)
        unlet b:tail_timer
    endif
endfunction

function! s:ToggleTailing()
    if exists('b:tail_timer')
        echo 'Disabling tailing'
        call s:DisableTailing()
    else
        echo 'Enabling tailing'
        call s:EnableTailing()
    endif
endfunction

nnoremap <silent> <localleader>F :call <SID>ToggleTailing()<CR>

let &cpoptions = s:cpo
