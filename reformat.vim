function! Reformat()
    " Save cursor position
    let l:save = winsaveview()

    " Do spacing options
    " Match every line that isn't a comment ( #, //, /* )
    let l:ignore_comment = '\%(^ *\%(\%(#\)\|\%(\/\/\)\|\%(\/\*\)\|\%(\*\)\).*\)\@<!'

    " Remove all spaces around parentheses
    execute '%s/' . l:ignore_comment . ' \+(/(/ge'
    execute '%s/' . l:ignore_comment . ' \+)/)/ge'
    execute '%s/' . l:ignore_comment . '( \+/(/ge'
    execute '%s/' . l:ignore_comment . ') \+/)/ge'

    " Re-add spaces around parentheses
    execute '%s/' . l:ignore_comment . '(/( /ge'
    execute '%s/' . l:ignore_comment . ')/ )/ge'
    execute '%s/' . l:ignore_comment . '( \+)/()/ge'

    " Space operators correctly in general
    "let l:not_within_quotes_st = '\%(".*\)\@<!'
    "let l:not_within_quotes_ed = '\%(.*"\)\@!'
    let l:match_op = '\(\%(\/\/\|\/\*\)\|\%(+=\|+\)\|\%(--\|-=\|-\)\|\%(\*=\|\*\)\|\%(\/\|\/=\)\|\%(==\|!=\|=\)\|\%(>>\|>=\|>\)\|\%(<<\|<=\|<\)\|\%(&&\|&=\|&\
    execute '%s/' . l:ignore_comment . ' *' . l:match_op . ' */ \1 /ge'

    " Make sure the { : are spaced correctly
    execute '%s/' . l:ignore_comment . ' *: */ : /ge'

    " File specific formatting
    let l:type = expand('%:e')
    if ( l:type == 'c' || l:type == 'cpp' || l:type == 'h' )
        " Only for C(++)
        execute '%s/' . l:ignore_comment . ' *{ */ { /ge'
    elseif ( l:type == 'py' )
        " Only for python
        execute '%s/' . l:ignore_comment . ')as/) as/ge'
        execute '%s/' . l:ignore_comment . ')for/) for/ge'
        execute '%s/' . l:ignore_comment . ')in/) in/ge'
    endif

    " Remove whitespace at end of line
    %s/\s\+$//ge

    " Move cursor back to orig position
    call winrestview(l:save)

    echo "Reformatted file"
endfunction
