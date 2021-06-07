" neovim python file type config
" Maintainer    Massoud Boorboor <boorboor@gmail.com>

setlocal expandtab  " Insert 'softtabstop' amount of space characters.
setlocal softtabstop=4  " Sets tab key width.
setlocal shiftwidth=4  " affects what happens when you press >>, << or ==.
setlocal showmatch  " Highlight pair parenthesis.
setlocal nowrap  " Disable line wrapping.
setlocal colorcolumn=80,119,120  " Add a colored column to avoid going too far
setlocal signcolumn=yes:2  " draw sign column even no sign present.
" setlocal foldclose=all  " close fold when leave line.
setlocal foldcolumn=3  " draw fold column.
setlocal foldlevel=1  " Start folding one indent level deep.
setlocal foldlevelstart=1  " Start folding on open buffer one level deep.
setlocal foldmethod=indent  " Fold base on indentation.
" setlocal foldminlines=5  " Fold if at least 3 lines are there.
setlocal foldnestmax=2  " Fold only one step in.
" setlocal foldopen=all  " Open fold when curser get line.
setlocal updatetime=200  " Update swap file time.
setlocal encoding=utf-8  " Use an encoding that supports Unicode.
setlocal fileformat=unix  " File format setting.
setlocal shortmess+=c
setlocal wildignore=*.pyc
setlocal path+=**

" Removing all trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Debuger insert mapping.
map <leader>d oimport pdb; pdb.set_trace() # BREAK POINT<ESC>
