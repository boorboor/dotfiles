
setlocal expandtab " Insert 'softtabstop' amount of space characters.
setlocal softtabstop=4 " Sets tab key width.
setlocal shiftwidth=4 " affects what happens when you press >>, << or ==.

setlocal wrap  " Disable line wrapping.
setlocal linebreak " Avoid wrapping a line in the middle of a word.
setlocal textwidth=119 " set max line width to 119(github page) for easy review.
setlocal colorcolumn=80 " Add a colored column to avoid going to far
highlight ColorColumn ctermbg=red
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/
match BadWhitespace /\s\+$/

setlocal nosmartindent
setlocal autoindent
let python_highlight_all=1
syntax on
filetype indent on

setlocal encoding=utf-8 " Use an encoding that supports Unicode.
setlocal fileformat=unix
setlocal wildignore=*.pyc

compiler pylint
let g:pylint_onwrite = 0
let g:pylint_cwindow = 0

map <leader>d oimport pdb; pdb.set_trace() # BREAK POINT<ESC>
map <leader>p ofrom pprint import pprint; pprint() # DEBUG<ESC>T(i
map <leader>f :update<CR>:!isort %<CR>:!autopep8 --in-place --aggressive --aggressive %<CR>
nnoremap <buffer> <F5> :update<bar>!python3 %<CR>
