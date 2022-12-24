" vim plug options

" For Chisel syntax highlighting
augroup ft_scala
    autocmd!
    autocmd Syntax scala syn keyword chiselKeyword when elsewhen otherwise
    autocmd Syntax scala hi link chiselKeyword Keyword
    autocmd Syntax scala syn match chiselFunction /\<printf\>/
    autocmd Syntax scala hi link chiselFunction Function
    autocmd Syntax scala syn match chiselOperator "==="
    autocmd Syntax scala syn match chiselOperator "=/="
    autocmd Syntax scala syn match chiselOperator "+%"
    autocmd Syntax scala syn match chiselOperator "+&"
    autocmd Syntax scala syn match chiselOperator "-%"
    autocmd Syntax scala syn match chiselOperator "-&"
    autocmd Syntax scala hi link chiselOperator Special
augroup end

au BufRead,BufNewFile *.fir set filetype=firrtl

" Have ctags automatically check for all tags first and present them
nnoremap <C-]> g<C-]>
