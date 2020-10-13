setlocal expandtab " Insert 'softtabstop' amount of space characters.
setlocal softtabstop=4 " Sets tab key width.
setlocal shiftwidth=4 " affects what happens when you press >>, << or ==.

setlocal wrap  " Disable line wrapping.
setlocal linebreak " Avoid wrapping a line in the middle of a word.
setlocal textwidth=119 " Set max line width to 119(github page) for easy review.
setlocal colorcolumn=80 " Add a colored column to avoid going to far
setlocal showmatch " Highlight pair parenthesis.
setlocal listchars=eol:⏎,tab:\ \ ┊,trail:•,extends:…,precedes:…,space:⎵
setlocal signcolumn=yes

setlocal foldenable " Enable folding.
setlocal foldmethod=indent " Fold base on indentation.
setlocal foldnestmax=2  " Fold only one step in.

setlocal updatetime=1000
setlocal nosmartindent
setlocal autoindent
syntax enable
filetype plugin on

command! MakeTags ctags -R .
command! Run python3 -i %
setlocal encoding=utf-8 " Use an encoding that supports Unicode.
setlocal fileformat=unix
setlocal path+=**
setlocal wildignore=*.pyc

nnoremap gb :ls<cr>:b<space>


map <leader>l :set invlist<cr>
map <leader>d oimport pdb; pdb.set_trace() # BREAK POINT<ESC>
map <leader>p ofrom pprint import pprint; pprint() # DEBUG<ESC>T(i
"map <leader>f :update<CR>:!isort '%'<CR>:!autopep8 --in-place --aggressive --aggressive %<CR>
map <leader>i :update<CR>:!isort '%'<CR>
map <leader>f :update<CR>:!clear; pylint '%'<CR>
map <silent> <F5> :update<bar>!clear; python3 '%'<CR>

highlight SpellBad cterm=underline " Underline missspelled words.
" Highlight trailing spaces and tabs charachters in red background.
highlight TrailingSpaceChar ctermbg=1
highlight TabChar ctermbg=1
syn match TrailingSpaceChar " *$"
syn match TabChar "\t"
