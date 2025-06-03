
"setlocal omnifunc=javacomplete#Complete

let s:jdt_ls_debugger_port = 0
function! s:StartDebugging()
  if s:jdt_ls_debugger_port <= 0
    " Get the DAP port
    let s:jdt_ls_debugger_port = youcompleteme#GetCommandResponse(
      \ 'ExecuteCommand',
      \ 'vscode.java.startDebugSession' )

    if s:jdt_ls_debugger_port == ''
       echom "Unable to get DAP port - is JDT.LS initialized?"
       let s:jdt_ls_debugger_port = 0
       return
     endif
  endif

  let args = { 'DAPPort': s:jdt_ls_debugger_port }
  call extend(args, s:ResolveClasspath())

  " Start debugging with the DAP port
  call vimspector#LaunchWithSettings( args )
endfunction

function! s:ResolveClasspath() abort
    if !exists('b:jdt_ls_project_name')
        let b:jdt_ls_project_name = input(
                    \ "Enter the project name: ",
                    \ get(g:, 'jdt_ls_project_name', ''))
    endif

    if empty(b:jdt_ls_project_name)
        echom "Project name is required"
        unlet b:jdt_ls_project_name
        return {}
    endif

    if !exists('b:jdt_ls_main_class')
        let b:jdt_ls_main_class = input(
                    \ "Enter the main class (blank to guess): ",
                    \ get(g:, 'jdt_ls_main_class', ''))
    endif

    if empty(b:jdt_ls_main_class)
        unlet b:jdt_ls_main_class

        let main_class_info = youcompleteme#GetCommandResponse(
            \ 'ExecuteCommand',
            \ 'vscode.java.resolveMainClass',
            \ b:jdt_ls_project_name )

        if empty(main_class_info)
            echo "Failed to resolve main class path info; can't expand classpath"
            return {}
        endif

        let main_classes = map(json_decode(main_class_info), {_, v -> v.mainClass})
        let options = map(main_classes, {i, v -> string(i+1) .. ': ' .. v})
        let selected = inputlist(["Which main class?"] + options)
        if selected > 0
            let b:jdt_ls_main_class = main_classes[selected - 1]
            echom "Storing main class in b:jdt_ls_main_class: " . b:jdt_ls_main_class
        endif
    endif

    if !exists('b:jdt_ls_main_class') || empty(b:jdt_ls_main_class)
        unlet! b:jdt_ls_main_class
        echo "Failed to resolve main class; can't expand classpath"
        return {}
    endif


    " TODO: We probably don't always want to do this. Better to have a callback
    " when resolving the calculus, but i don't think you can do arbitrary
    " functions in the calculus (though that would be cool)
    return {
        \ 'AutoClasspath': s:JoinClasspaths(youcompleteme#GetCommandResponse(
            \ 'ExecuteCommand',
            \ 'vscode.java.resolveClasspath',
            \ b:jdt_ls_main_class,
            \ b:jdt_ls_project_name,
            \ 'auto' )),
        \ 'RuntimeClasspath': s:JoinClasspaths(youcompleteme#GetCommandResponse(
            \ 'ExecuteCommand',
            \ 'vscode.java.resolveClasspath',
            \ b:jdt_ls_main_class,
            \ b:jdt_ls_project_name,
            \ 'runtime' )),
        \ 'TestClasspath': s:JoinClasspaths(youcompleteme#GetCommandResponse(
            \ 'ExecuteCommand',
            \ 'vscode.java.resolveClasspath',
            \ b:jdt_ls_main_class,
            \ b:jdt_ls_project_name,
            \ 'test' )),
        \ 'ProjectName': b:jdt_ls_project_name,
        \ 'MainClass': b:jdt_ls_main_class,
        \ }
endfunction

function s:JoinClasspaths(resolved)
    " For some reason, the response is a list of lists
    let cps = json_decode(a:resolved)
    let entry_list = []
    for cp_list in cps
        call extend(entry_list, cp_list)
    endfor
    " The vimspector splat works with strings, not lists, so let's hope there
    " are no spaces in the classpath entries (we _could_ shellescape them of
    " course)
    return join( entry_list, ' ' )
endfunction

nnoremap <silent> <buffer> <Leader><F5> :call <SID>StartDebugging()<CR>
autocmd BufWritePre,FileWritePre <buffer> call youcompleteme#FormatPreFileSave()
