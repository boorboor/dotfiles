
setlocal tabstop=4
setlocal softtabstop=4 " Sets tab key width.
setlocal shiftwidth=4 " affects what happens when you press >>, << or ==.
setlocal noexpandtab
setlocal cindent cino=j1,(0,ws,Ws

setlocal wrap  " Disable line wrapping.
setlocal linebreak " Avoid wrapping a line in the middle of a word.
setlocal textwidth=119 " set max line width to 119(github page) for easy review.
setlocal colorcolumn=119
highlight ColorColumn ctermbg=red

let &path.="src/include,/usr/include/AL," " Search path for `gf`.
" execute "nnoremap <silent> ".g:formatterTrigger." :call Formatters#Uncrustify#Cpp()<Cr>"

nnoremap <F5> :make<cr>  && ./my_great_program<cr>
map <F6> :w<CR>:!clang % -o %:r.out && ./%:r.out<CR>

