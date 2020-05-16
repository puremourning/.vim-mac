syn region jsonComment start="/\*" end="\*/"

" I like comments (also vimspector uses them)
hi link jsonCommentError Comment
hi link jsonComment Comment
