" neovim golang file type config
" Maintainer    Massoud Boorboor <boorboor@gmail.com>

setlocal noexpandtab " NOT insert 'softtabstop' amount of space characters.
setlocal softtabstop=8 " Sets tab key width.
setlocal shiftwidth=8 " Affects what happens when you press >>, << or ==.
setlocal showmatch  " Highlight pair parenthesis.
setlocal nowrap  " Disable line wrapping.
setlocal colorcolumn=119,120  " Add a colored column to avoid going too far
setlocal signcolumn=yes:2  " draw sign column even no sign present.
setlocal foldcolumn=3  " draw fold column.
" setlocal foldclose=all  " close fold when leave line.
" setlocal foldlevel=0  " Start folding one indent level deep.
" setlocal foldlevelstart=0  " Start folding on open buffer one level deep.
" setlocal foldmethod=syntax  " Fold base on indentation.
" setlocal foldminlines=3  " Fold if at least 3 lines are there.
" setlocal foldnestmax=2  " Fold only one step in.
" setlocal foldopen=all  " Open fold when curser get line.
setlocal updatetime=200  " Update swap file time.
setlocal encoding=utf-8  " Use an encoding that supports Unicode.
setlocal fileformat=unix  " File format setting.
setlocal shortmess+=c

" Removing all trailing whitespace
autocmd BufWritePre * %s/\s\+$//e
