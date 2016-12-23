set nocompatible
filetype off

" YCM config
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf=0
let g:ycm_server_log_level='debug'
let g:ycm_always_populate_location_list=1
"let g:ycm_server_use_unix_domain_socket=1
let g:ycm_extra_conf_vim_data = [ '&filetype' ]
let g:ycm_add_preview_window_to_completeopt = 1
let g:ycm_always_populate_location_list=1
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_collect_identifiers_from_tags_files=1
"let g:ycm_show_diagnostics_ui=0
let g:ycm_rust_src_path=expand( '$HOME/Development/rust/src' )
let g:ycm_racerd_binary_path=expand( '$HOME/.vim/bundle/YouCompleteMe-Clean/third_party/ycmd/third_party/racerd/target/debug/racerd' )

let g:ycm_use_syntastic_loc_list = 1

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'puremourning/YouCompleteMe', { 'name': 'YouCompleteMe-Clean' }

call vundle#end()
filetype plugin indent on

