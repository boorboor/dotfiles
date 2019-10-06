
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
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/
match BadWhitespace /\s\+$/

setlocal encoding=utf-8 " Use an encoding that supports Unicode.
setlocal fileformat=unix
setlocal wildignore=*.out

let &path.="src/include,/usr/include/AL," " Search path for `gf`.
" execute "nnoremap <silent> ".g:formatterTrigger." :call Formatters#Uncrustify#Cpp()<Cr>"

map <silent> <F5> :update<bar> !clear; g++ -Wall -std=c++14 % -o '%<' && ./'%<'<CR>

