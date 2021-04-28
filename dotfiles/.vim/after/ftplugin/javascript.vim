setlocal expandtab " Insert 'softtabstop' amount of space characters.
setlocal softtabstop=2 " Sets tab key width.
setlocal shiftwidth=2 " affects what happens when you press >>, << or ==.

setlocal wrap  " Disable line wrapping.
setlocal linebreak " Avoid wrapping a line in the middle of a word.
setlocal textwidth=119 " Set max line width to 119(github page) for easy review.
setlocal colorcolumn=80 " Add a colored column to avoid going to far
setlocal showmatch " Highlight pair parenthesis.
setlocal listchars=eol:⏎,tab:\ \ ┊,trail:•,extends:…,precedes:…,space:⎵

setlocal signcolumn=yes
setlocal autoindent
syntax enable
filetype plugin on

setlocal equalprg=js-beautify --indent-size=2 --replace %

map <leader>f :update<CR>:!clear; pylint --disable C0114,C0115,E0401 '%'<CR>
