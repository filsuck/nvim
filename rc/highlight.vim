" vim: fdm=marker
" File: highlight.vim
" Author: romgrk
" Date: 16 Oct 2015
" !::exe [So]

exe 'augroup ' . expand('<sfile>:t') | au!
au ColorScheme * exe 'source ' . expand('<sfile>:p')
au VimEnter * :call pp#prettyTheme()
exe 'augroup END'

" General                                                                    {{{

hi! link QuickFixLine Highlight

"call hi#("Highlight", hi#("Search"))

hi! link    Noise          Comment

" }}}
" Plugin specific                                                            {{{

hi! link SearchReplaceMatch      EasyMotionTargetDefault
hi! link SneakLabel              EasyMotionTargetDefault
hi! link SneakLabelMask          Noise

hi! CocInfoSign                       guifg=#0E8FFF
hi! CocInfoHighlight    gui=undercurl guisp=#0E8FFF
hi! CocWarningSign                    guifg=#FF9F0E
hi! CocWarningHighlight gui=undercurl guisp=#FF9F0E
hi! CocErrorSign                      guisp=#ff1010
hi! CocErrorHighlight   gui=undercurl guisp=#ff1010

hi! CocInfoFloat                      guifg=white
hi! CocWarningFloat                   guifg=#FFDD86
hi! CocErrorFloat                     guifg=#FDC1C1

hi link gitmessengerHeader Normalfloat

" === Clap ===

hi! link ClapCurrentSelection Visual
hi! link ClapPopupCursor      Visual
hi! link ClapInput            NormalPopup
hi! link ClapSearchText       NormalPopup
hi! link ClapDisplay          NormalPopup
hi! link ClapMatches          EasyMotionTargetDefault
hi! link ClapPreview          StatusLine
hi! link ClapSpinner          StatusLine
hi! link ClapQuery            Normal

hi! link ClapFile             NormalPopup

hi! link ClapMatches1 EasyMotionTargetDefault
hi! link ClapMatches2 EasyMotionTargetDefault
hi! link ClapMatches3 EasyMotionTargetDefault
hi! link ClapMatches4 EasyMotionTargetDefault
hi! link ClapMatches5 EasyMotionTargetDefault
hi! link ClapMatches6 EasyMotionTargetDefault
hi! link ClapMatches7 EasyMotionTargetDefault
hi! link ClapMatches8 EasyMotionTargetDefault
hi! link ClapMatches9 EasyMotionTargetDefault
hi! link ClapMatches10 EasyMotionTargetDefault
hi! link ClapFuzzyMatches1 EasyMotionTargetDefault
hi! link ClapFuzzyMatches2 EasyMotionTargetDefault
hi! link ClapFuzzyMatches3 EasyMotionTargetDefault
hi! link ClapFuzzyMatches4 EasyMotionTargetDefault
hi! link ClapFuzzyMatches5 EasyMotionTargetDefault
hi! link ClapFuzzyMatches6 EasyMotionTargetDefault
hi! link ClapFuzzyMatches7 EasyMotionTargetDefault
hi! link ClapFuzzyMatches8 EasyMotionTargetDefault
hi! link ClapFuzzyMatches9 EasyMotionTargetDefault
hi! link ClapFuzzyMatches10 EasyMotionTargetDefault

hi! link ClapVistaTag         Normal

" By default ClapQuery will use the bold fg of Normal and the same bg of ClapInput

hi default link ClapPreview          ClapDefaultPreview
hi default link ClapSelected         ClapDefaultSelected
hi default link ClapCurrentSelection ClapDefaultCurrentSelection

" hi! ClapDefaultPreview          ctermbg=237 guibg=#3E4452
" hi! ClapDefaultSelected         cterm=bold,underline gui=bold,underline ctermfg=80 guifg=#5fd7d7
hi! link ClapDefaultSelected Visual
hi! link ClapDefaultCurrentSelection Visual



if (&bg == 'light')
    " hi! link MatchParen          bg_brightteal
    hi! link hiPairs_matchPair   bg_brightteal
    hi! link hiPairs_unmatchPair bg_brightteal

    hi! link HighlightedyankRegion Highlight
else
    hi! link MatchParen          b_brightteal
    hi! link hiPairs_matchPair   b_brightteal
    hi! link hiPairs_unmatchPair b_brightteal

    hi! link HighlightedyankRegion Search
end

call hi#('multiple_cursors_cursor', colors.darkred, colors.pink, 'bold')
hi! link multiple_cursors_visual visual


" }}}
" Notes, notation, etc.                                                      {{{
hi! link vifmNotation        OldSpecial
hi! link notesXXX            TextError
hi! link notesDoneMarker     TextSuccess
hi! link notesTODO           TextWarning
" }}}
