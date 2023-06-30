" Don't treat # like c preprocessor
setlocal cinoptions+=#1

" Undo heinous things that the $VIMRUNTIME/ftplugin/python.vim does for PEP8
" which are not compatible with YCM style which is what i use most of the time.
setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
