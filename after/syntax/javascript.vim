" !::exe [so %]
" Language:	JavaScript
"let s:cpo_save = &cpo
"set cpo&vim
"let &cpo = s:cpo_save
"unlet s:cpo_save

hi! link jsFuncBraces      Delimiter
hi! link jsBraces          Delimiter
hi! link jsBrackets        Delimiter2

"hi! link jsThis            Var3
hi! link jsThis            jsPrototype
hi! link jsFunction        Keyword
hi! link jsFuncCall        Function
hi! link jsFuncAssignIdent Function
hi! link jsAssignExpIdent  Identifier
hi! link jsStorageClass    StorageClass
hi! link jsGlobalObjects   Global
hi! link jsObjectKey       Property
hi! link jsArrowFunction   Keyword
hi! link jsNull            Constant
hi! link jsUndefined       Constant
hi! link jsFuncArgs        Argument
hi! link jsBuiltins        Predefined

"let g:javascript_conceal_function       = "ƒ"
"let g:javascript_conceal_arrow_function = "⇒"
unlet! g:javascript_conceal_function
unlet! g:javascript_conceal_arrow_function
unlet! g:javascript_ignore_javaScriptdoc
unlet! g:javascript_conceal_return
unlet! g:javascript_conceal_this
" let g:javascript_conceal_this = '@'
unlet! g:javascript_conceal_undefined
unlet! g:javascript_conceal_null
unlet! g:javascript_conceal_prototype
unlet! g:javascript_conceal_static
unlet! g:javascript_conceal_super
"syntax match commentTitle /\v.? \zs\w+:/
"syntax keyword  commentTODO  TODO
"syntax keyword  commentXXX   XXX
"syntax keyword  commentFIXME FIXME
"syntax cluster Comments contains=commentTitle,commentTODO,commentXXX,commentFIXME