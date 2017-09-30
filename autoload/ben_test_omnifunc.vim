function! ben_test_omnifunc#Complete(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    " find months matching with "a:base"
    let res = [ 'something', 'Unicøde', 'test', 'test2' ]
    return res
  endif
endfun

