" Basic plugin boilerplate

let s:cpo = &cpoptions
set cpoptions&vim

function! UUIDGen()
    let uuid = system('uuidgen')
    return trim(uuid)
endfunction

function! s:opfunc( motion_type = '' )
    if a:motion_type == ''
        let &opfunc=funcref('<SID>opfunc')
        " TODO: Count/register?

        " Invoke ourself
        return 'g@'
    endif

    if a:motion_type != 'char'
        return
    endif



    let line = getline('.')

    " These mark positions are wierd.
    " for the This in '..This..', " start is 3, end is 6
    " We want 0-based indexs and we want the range to be 4 characters long in
    " that example, so we use start-1 (o-based) and end (i.e. end+1-1)
    "
    " But it's even stupider for empty ranges. For the:
    " first ( with i( in '  ()", we get start = 4, end = 3
    let start = col("`[")
    let end = col("`]")

    if start > end
        return
    endif

    call setline('.', line[0:start-1] .. UUIDGen() .. line[end:])
endfunction

nnoremap <silent> <expr> <leader>UU <SID>opfunc()
vnoremap <leader>UU c<C-R>=UUIDGen()<CR>


let &cpoptions = s:cpo
