function! Reformat()
    " Save cursor position
    let l:save = winsaveview()

    " Do spacing options
    " Match every line that isn't a comment ( #, //, /* )
    let l:ignore_comment = '\(\(\(#\)\|\(\/\/\)\|\(\/\*\)\|\(\*\)\).*\)\@<!'

    " Remove all spaces around parentheses
    execute '%s/' . l:ignore_comment . ' \+(/(/ge'
    execute '%s/' . l:ignore_comment . ' \+)/)/ge'
    execute '%s/' . l:ignore_comment . '( \+/(/ge'
    execute '%s/' . l:ignore_comment . ') \+/)/ge'

    " Re-add spaces around parentheses
    execute '%s/' . l:ignore_comment . '(/( /ge'
    execute '%s/' . l:ignore_comment . ')/ )/ge'
    execute '%s/' . l:ignore_comment . '( \+)/()/ge'

    " Make sure operators are spaced properly
    execute '%s/' . l:ignore_comment . ') *>/) >/ge'
    execute '%s/' . l:ignore_comment . ') *</) </ge'
    execute '%s/' . l:ignore_comment . ') *>=/) >=/ge'
    execute '%s/' . l:ignore_comment . ') *<=/) <=/ge'
    execute '%s/' . l:ignore_comment . ') *==/) ==/ge'
    execute '%s/' . l:ignore_comment . ') *!=/) !=/ge'
    execute '%s/' . l:ignore_comment . ') *+/) +/ge'
    execute '%s/' . l:ignore_comment . ') *-/) -/ge'
    execute '%s/' . l:ignore_comment . ') *\*/) \*/ge'
    execute '%s/' . l:ignore_comment . ') *\//) \//ge'

    " Make sure the { : are spaced correctly
    execute '%s/' . l:ignore_comment . ' *: */ : /ge'
    execute '%s/' . l:ignore_comment . ' *{ */ { /ge'

    " Only for python
    execute '%s/' . l:ignore_comment . ')as/) as/ge'

    " Remove whitespace at end of line
    %s/\s\+$//ge

    " Move cursor back to orig position
    call winrestview(l:save)

    echo "Re-spaced parentheses"
endfunction
