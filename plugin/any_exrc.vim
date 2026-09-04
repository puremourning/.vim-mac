let s:cpo = &cpoptions
set cpoptions&vim

function! LoadAnyExrc()
    " If there's an .exrc in cwd, do nothing.
    " Otherwise search up the hierarchy to find one.
    " If found, source it as if 'set exrc' were used in that cwd
    if filereadable(".exrc")
        return
    endif

    let exrc = findfile(".exrc", ".;")
    if !empty(exrc)
        if confirm("Found .exrc in " . fnamemodify(exrc, ":h") . ". Load it?",
                    \ "&Yes\n&No", 1) == 1
            execute 'silent! cd ' fnamemodify(exrc, ":h")
            execute 'source' fnameescape(exrc)
        endif
    endif
endfunction

autocmd VimEnter * call LoadAnyExrc()

let &cpoptions = s:cpo


