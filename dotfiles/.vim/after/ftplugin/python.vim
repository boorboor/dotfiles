setlocal expandtab " Insert 'softtabstop' amount of space characters.
setlocal softtabstop=4 " Sets tab key width.
setlocal shiftwidth=4 " affects what happens when you press >>, << or ==.

setlocal wrap  " Disable line wrapping.
setlocal linebreak " Avoid wrapping a line in the middle of a word.
setlocal textwidth=119 " Set max line width to 119(github page) for easy review.
setlocal colorcolumn=80 " Add a colored column to avoid going to far
setlocal showmatch " Highlight pair parenthesis.
setlocal cursorline " Make line cursor placed highlighted.

setlocal foldenable " Enable folding.
setlocal foldmethod=indent " Fold base on indentation.
setlocal foldnestmax=3  " Fold only one step in.

setlocal nosmartindent
setlocal autoindent
syntax enable
filetype plugin on

setlocal encoding=utf-8 " Use an encoding that supports Unicode.
setlocal fileformat=unix
setlocal wildignore=*.pyc

map <leader>d oimport pdb; pdb.set_trace() # BREAK POINT<ESC>
map <leader>p ofrom pprint import pprint; pprint() # DEBUG<ESC>T(i
map <leader>f :update<CR>:!isort %<CR>:!autopep8 --in-place --aggressive --aggressive %<CR>
map <leader>i :update<CR>:!isort %<CR>
map <silent> <F5> :update<bar>!clear; python3 '%'<CR>

