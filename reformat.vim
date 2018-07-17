function! Reformat()
    " Save cursor position
    let l:save = winsaveview()

    " Do spacing options

    " Remove all spaces around parentheses
    %s/ \+(/(/g
    %s/ \+)/)/g
    %s/( \+/(/g
    %s/) \+/)/g

    " Re-add spaces around parentheses
    %s/(/( /g
    %s/)/ )/g
    %s/( \+)/()/g

    " Make sure operators are spaced properly
    %s/) *>/) >/g
    %s/) *</) </g
    %s/) *>=/) >=/g
    %s/) *<=/) <=/g
    %s/) *==/) ==/g
    %s/) *!=/) !=/g
    %s/) *+/) +/g
    %s/) *-/) -/g
    %s/) *\*/) \*/g
    %s/) *\//) \//g

    " Make sure the { : are spaced correctly
    %s/ *: */ : /g
    "%s/ *{ */ { /g

    " Remove whitespace at end of line
    %s/\s\+$//

    " Move cursor back to orig position
    call winrestview(l:save)

    echo "Re-spaced parentheses"
endfunction
