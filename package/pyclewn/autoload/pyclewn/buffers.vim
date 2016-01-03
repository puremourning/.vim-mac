" vi:set ts=8 sts=4 sw=4 et tw=80:
" Pyclewn run time file.
" Maintainer:   <xdegaye at users dot sourceforge dot net>
"
" Manage pyclewn buffers.
"
if exists("s:did_buffers")
    finish
endif
let s:did_buffers = 1

"---------------------   AUTOLOAD FUNCTIONS   ---------------------

" Load the Pyclewn buffers in their windows. This function is called at the
" first Pyclewn command.
"
"   'debugger': the debugger being run
"   'window':   the value of the '--window' option, i.e. "top", "bottom",
"               "left", "right", "none" or "usetab".
"
function pyclewn#buffers#CreateWindows(debugger, window)
    " Add the clewn buffers to the buffer list.
    badd (clewn)_console
    if a:debugger == "gdb"
        badd (clewn)_breakpoints
        badd (clewn)_backtrace
        badd (clewn)_threads
    endif
    if bufname("%") == ""
        edit (clewn)_empty
        set nobuflisted
    endif

    if a:window == "usetab"
        set switchbuf=usetab
        let l:tabno = tabpagenr()
        tabnew
        set nobuflisted
        if exists("*Pyclewn_CreateTabWindows")
            call Pyclewn_CreateTabWindows(a:debugger)
        else
            call s:create_tab_windows(a:debugger)
        endif
        exe "tabnext " . l:tabno
    else
        if exists("*Pyclewn_CreateWindows")
            call Pyclewn_CreateWindows(a:debugger, a:window)
        else
            call s:create_windows(a:debugger, a:window)
        endif
    endif
endfunction

" Display the '(clewn)_variables' buffer in a window, split if needed. The
" function is called before the 'Cdbgvar' command is executed.
function pyclewn#buffers#DbgvarSplit()
    if exists("*Pyclewn_DbgvarSplit")
        call Pyclewn_DbgvarSplit()
        return
    endif
    call s:goto_window("(clewn)_variables", "")
endfunction

" Display the frame source code in a window. The function is called after the
" <CR> key or the mouse is used in a '(clewn)_backtrace' window. The line number
" is not available (to avoid screen blinks) in this window, but the ensuing
" 'Cframe' command will automatically move the cursor to the right place.
"   'fname': the source code full path name.
function pyclewn#buffers#GotoFrame(fname)
    if exists("*Pyclewn_GotoFrame")
        call Pyclewn_GotoFrame(a:fname)
        return
    endif
    call s:goto_window(a:fname, "")
endfunction

" Display the breakpoint source code in a window. The function is called after
" the <CR> key or the mouse is used in a '(clewn)_breakpoints' window.
"   'fname': the source code full path name.
"   'lnum':  the source code line number.
function pyclewn#buffers#GotoBreakpoint(fname, lnum)
    if exists("*Pyclewn_GotoBreakpoint")
        call Pyclewn_GotoBreakpoint(a:fname, a:lnum)
        return
    endif
    call s:goto_window(a:fname, a:lnum)
endfunction

"-------------------   END AUTOLOAD FUNCTIONS   -------------------

" Create the clewn buffers windows in a tab page.
function s:create_tab_windows(debugger)
    edit (clewn)_console
    if a:debugger == "gdb"
        split
        let w:pyclewn_window = 1
        wincmd w
        edit (clewn)_threads
        let w:pyclewn_window = 1
        split
        edit (clewn)_breakpoints
        let w:pyclewn_window = 1
        split
        edit (clewn)_backtrace
        let w:pyclewn_window = 1

        " Resize the windows to have the 'breakpoints' and 'threads' windows
        " with a height of 8 and 4.
        2wincmd j
        resize 4
        wincmd k
        let l:breakpoints_height = winheight(0)
        wincmd k
        let l:backtrace_height = winheight(0) + l:breakpoints_height - 8
        if l:backtrace_height > 0
            exe "resize " . l:backtrace_height
        endif
    endif
endfunction

" Create the clewn buffers windows according to the 'window' value.
function s:create_windows(debugger, window)
    let l:bufno = bufnr("%")
    let l:spr = &splitright
    let l:sb = &splitbelow
    set nosplitbelow
    set nosplitright

    if a:window == "top"
        1wincmd w
        exe &previewheight . "split"
        edit (clewn)_console

    elseif a:window == "bottom"
        exe winnr("$") . "wincmd w"
        set splitbelow
        exe &previewheight . "split"
        set nosplitbelow
        edit (clewn)_console

    elseif a:window == "right"
        set splitright
        vsplit
        set nosplitright
        edit (clewn)_console

    elseif a:window == "left"
        vsplit
        edit (clewn)_console

    else    " none
        let &splitbelow = l:sb
        let &splitright = l:spr
        return
    endif

    let w:pyclewn_window = 1
    if a:debugger == "gdb"
        let l:split_cmd = "split"
        if a:window == "top"
            exe (&previewheight - 4) . "split"
            let w:pyclewn_window = 1
            wincmd w
            let l:split_cmd = "vsplit"
        elseif a:window == "bottom"
            4split
            let l:split_cmd = "vsplit"
        elseif a:window == "right" || a:window == "left"
            split
        endif

        edit (clewn)_threads
        let w:pyclewn_window = 1
        exe l:split_cmd
        edit (clewn)_backtrace
        let w:pyclewn_window = 1
        exe l:split_cmd
        edit (clewn)_breakpoints
        let w:pyclewn_window = 1
    endif

    let &splitbelow = l:sb
    let &splitright = l:spr
    exe bufwinnr(l:bufno) . "wincmd w"
endfunction

function s:goto_window(fname, lnum)
    " Search for a window in the tab pages, starting first with the current tab
    " page.
    let l:curtab = tabpagenr()
    for l:tabidx in range(tabpagenr('$'))
        let l:tabno = ((l:tabidx + l:curtab - 1) % tabpagenr('$')) + 1
        for l:bufno in tabpagebuflist(l:tabno)
            if expand("#" . l:bufno . ":p") == a:fname || expand("#" . l:bufno) == a:fname
                if l:curtab != l:tabno
                    exe "tabnext " . l:tabno
                endif
                exe bufwinnr(l:bufno) . "wincmd w"
                if a:lnum != ""
                    call cursor(a:lnum, 0)
                endif
                return
            endif
        endfor
    endfor

    " Search for a non clewn buffer window to split, starting with the current
    " tab page and possibly using a '(clewn)_empty' window.
    try
        for l:tabidx in range(tabpagenr('$'))
            let l:tabno = ((l:tabidx + l:curtab - 1) % tabpagenr('$')) + 1
            for l:bufno in tabpagebuflist(l:tabno)
                if bufname(l:bufno) !~# "^(clewn)_" || bufname(l:bufno) == "(clewn)_empty"
                    if l:curtab != l:tabno
                        exe "tabnext " . l:tabno
                    endif
                    exe bufwinnr(l:bufno) . "wincmd w"
                    throw "break"
                endif
            endfor
        endfor
    catch /break/
    endtry

    " Split the window except if it is '(clewn)_empty'.
    let l:do_split = 1
    if bufname("%") == "(clewn)_empty"
        let l:do_split = 0
        exe "edit " . a:fname
    endif

    " Always split '(clewn)_variables' to work around windows switching caused
    " by goto_last().
    if l:do_split || a:fname == "(clewn)_variables"
        split
        exe "edit " . a:fname
    endif

    if a:lnum != ""
        call cursor(a:lnum, 0)
    endif
endfunction

