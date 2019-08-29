setlocal expandtab " Insert 'softtabstop' amount of space characters.
setlocal softtabstop=2 " Sets tab key width.
setlocal shiftwidth=2 " affects what happens when you press >>, << or ==.

setlocal wrap  " Disable line wrapping.
setlocal linebreak " Avoid wrapping a line in the middle of a word.
setlocal textwidth=119 " set max line width to 119(github page) for easy review.
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/
match BadWhitespace /\s\+$/

setlocal nosmartindent
setlocal autoindent
syntax on
filetype indent on

setlocal encoding=utf-8 " Use an encoding that supports Unicode.
setlocal fileformat=unix
