"=============================================================================
" !::exe [SO | Redraw | Warn ' SOURCED' ]

" let ycm_global_ycm_extra_conf = $rc . '/ycm.py'
let ycm_confirm_extra_conf    = 1
let ycm_extra_conf_globlist   = ['~/projects/*', '!~/downloads/*', '~/*']

let ycm_cache_omnifunc = 1
let ycm_min_num_of_chars_for_completion     = 3

"let ycm_seed_identifiers_with_syntax = 1
"let ycm_collect_identifiers_from_tags_files = 1
let ycm_use_ultisnips_completer = 0

let ycm_server_log_level = 'debug'

let ycm_add_preview_to_completeopt = 0
let ycm_always_populate_location_list = 1
let ycm_autoclose_preview_window_after_insertion = 0

let ycm_filetype_blacklist = {
\ 'tagbar' : 1,
\ 'qf' : 1,
\ 'notes' : 1,
\ 'markdown' : 1,
\ 'unite' : 1,
\ 'text' : 1,
\ 'vimwiki' : 1,
\ 'pandoc' : 1,
\ 'infolog' : 1,
\ 'mail' : 1
\}


let ycm_rust_src_path = expand("$HOME/src/rustc-1.8.0/src")

"=============================================================================