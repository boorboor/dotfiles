
setlocal expandtab " Insert 'softtabstop' amount of space characters.
setlocal softtabstop=2 " Sets tab key width.
setlocal shiftwidth=2 " Affects what happens when you press >>, << or ==.

setlocal wrap  " Disable line wrapping.
setlocal linebreak " Avoid wrapping a line in the middle of a word.
setlocal textwidth=119 " Set max line width to 119(github page) for easy review.
setlocal colorcolumn=119 " Add a colored column to avoid going to far
highlight ColorColumn ctermbg=1

set nosmartindent

imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
