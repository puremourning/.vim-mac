" vi:set ts=8 sts=4 sw=4 et tw=80:
" Pyclewn run time file.
" Maintainer:   <xdegaye at users dot sourceforge dot net>
"
" Configure VIM to be used with pyclewn and netbeans.
"
if exists("s:did_start")
    finish
endif
let s:did_start = 1

" The following global variables define how pyclewn is started. They may be
" changed to suit your preferences.
function s:init(debugger)
    if exists("g:pyclewn_terminal")
        let s:terminal = g:pyclewn_terminal
    else
        let s:terminal = ""
    endif

    if exists("g:pyclewn_python")
        let s:python = g:pyclewn_python
    else
        let s:python = "python"
    endif

    if exists("g:pyclewn_args")
        let s:args = g:pyclewn_args
    else
        let s:args = "--window=top --maxlines=10000 --background=Cyan,Green,Magenta"
    endif

    if exists("g:pyclewn_connection")
        let s:connection = g:pyclewn_connection
    else
        if a:debugger == "gdb"
            let s:connection = "127.0.0.1:3219:changeme"
        elseif a:debugger == "pdb"
            let s:connection = "127.0.0.1:3220:changeme"
        else
            let s:connection = "127.0.0.1:3221:changeme"
        endif
    endif

    " Uncomment the following line to print full traces in a file named
    " 'logfile' for debugging purpose (or change g:pyclewn_args).
    " let s:args .= " --level=nbdebug --file=logfile"
    if s:terminal != ""
        let s:args .= " --level=info"
    endif

    let l:fixed_args = "--editor= --netbeans=" . s:connection . " --cargs="
    if s:terminal != ""
        let s:fixed = l:fixed_args
    else
        let s:fixed = "--daemon " . l:fixed_args
    endif
endfunction

" Run the 'Cinterrupt' command to open the console.
function s:interrupt(args)
    " find the prefix
    let argl = split(a:args)
    let prefix = "C"
    let idx = index(argl, "-x")
    if idx == -1
        let idx = index(argl, "--prefix")
        if idx == -1
            for item in argl
                if stridx(item, "--prefix") == 0
                    let pos = stridx(item, "=")
                    if pos != -1
                        let prefix = strpart(item, pos + 1)
                    endif
                endif
            endfor
        endif
    endif

    if idx != -1 && len(argl) > idx + 1
        let prefix = argl[idx + 1]
    endif

    " hack to prevent Vim being stuck in the command line with '--More--'
    echohl WarningMsg
    echo "About to run the 'interrupt' command."
    call inputsave()
    call input("Press the <Enter> key to continue.")
    call inputrestore()
    echohl None
    exe prefix . "interrupt"
endfunction

" Check wether pyclewn successfully wrote the script file.
function s:pyclewn_ready(filename)
    let l:cnt = 1
    echohl WarningMsg
    while l:cnt < 20
        echon "."
        let l:cnt = l:cnt + 1
        if filereadable(a:filename)
            break
        endif
        sleep 200m
    endwhile
    echohl None
    if !filereadable(a:filename)
        throw "Error: pyclewn failed to start."
    endif
    call s:info("Creation of vim script file \"" . a:filename . "\": OK.\n")
endfunction

" Start pyclewn and vim netbeans interface.
function s:start(args, pdb_attach)
    if !exists(":nbstart")
        call s:error("Error: the ':nbstart' vim command does not exist.")
        return
    endif
    if has("netbeans_enabled")
        call s:error("Error: netbeans is already enabled and connected.")
        return
    endif
    if !executable(s:python)
        call s:error("Error: '" . s:python . "' cannot be found or is not an executable.")
        return
    endif
    let l:tmpfile = tempname()

    " Remove the Console and the list buffers from the previous session.
    for l:idx in range(bufnr('$'))
        let l:bufno = l:idx + 1
        if bufname(l:bufno) =~# "^(clewn)_"
            exe l:bufno . "bwipeout"
        endif
    endfor

    " Start pyclewn and netbeans.
    if a:pdb_attach
        call s:info("Attaching to a Python process.\n")
    else
        call s:info("Starting pyclewn.\n")
    endif
    let l:run_pyclewn = s:python . " -m clewn " . s:fixed . l:tmpfile . " " . a:args
    if s:terminal == ""
        exe "silent !" . l:run_pyclewn . " &"
    else
        let l:run_terminal = join(split(s:terminal, ","), " ")
        exe "silent !" . l:run_terminal . " sh -c '" . l:run_pyclewn . " || sleep 600' &"
    endif

    call s:info("Running nbstart, <C-C> to interrupt.\n")
    call s:pyclewn_ready(l:tmpfile)
    exe "nbstart :" . s:connection

    " Source vim script.
    if has("netbeans_enabled")
        exe "source " . l:tmpfile
        call s:info("The netbeans socket is connected.\n")
        let argl = split(a:args)
        if index(argl, "pdb") == len(argl) - 1
            call s:interrupt(a:args)
        endif
    else
        throw "Error: the netbeans socket could not be connected."
    endif
endfunction

function pyclewn#start#StartClewn(...)
    let l:debugger = "gdb"
    if a:0 != 0
        let l:debugger = a:1
    endif
    call s:init(l:debugger)

    let l:args = s:args
    if a:0 != 0
        if index(["gdb", "pdb", "simple"], a:1) == -1
            call s:error("Unknown debugger '" . a:1 . "'.")
            return
        endif
        if a:0 > 1
            let l:args .= " --args \"" . join(a:000[1:], ' ') . "\""
        endif
        let l:args .= " " . a:1
    endif

    try
        call s:start(l:args, a:0 == 1 && a:1 == "pdb")
    catch /^Vim:Interrupt$/
        return
    catch /.*/
        call s:info("The 'Pyclewn' command has been aborted.\n")
        let l:err = v:exception . "\n"
        if a:0 == 1 && a:1 == "pdb"
            let l:err .= "Could not find a Python process to attach to.\n"
        else
            let l:err .= "To get the cause of the problem set the global variable"
            let l:err .= " 'pyclewn_terminal' to:\n"
            let l:err .= ":let g:pyclewn_terminal = \"xterm, -e\"\n"
        endif
        call s:error(l:err)
        " The vim console screen is garbled, redraw the screen.
        if !has("gui_running")
            redraw!
        endif
        " Clear the command line.
        echo "\n"
    endtry
endfunction

function s:info(msg)
    echohl WarningMsg
    echo a:msg
    echohl None
endfunction

function s:error(msg)
    echohl ErrorMsg
    echo a:msg
    call inputsave()
    call input("Press the <Enter> key to continue.")
    call inputrestore()
    echohl None
endfunction
