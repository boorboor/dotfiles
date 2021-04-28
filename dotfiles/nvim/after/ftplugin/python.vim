" neovim python file type config
" Maintainer    Massoud Boorboor <boorboor@gmail.com>

setlocal expandtab  " Insert 'softtabstop' amount of space characters.
setlocal softtabstop=4  " Sets tab key width.
setlocal shiftwidth=4  " affects what happens when you press >>, << or ==.
setlocal showmatch  " Highlight pair parenthesis.
setlocal nowrap  " Disable line wrapping.
setlocal colorcolumn=80,119,120  " Add a colored column to avoid going too far
setlocal signcolumn=yes  " draw sign column even no sign present.
setlocal foldenable  " Enable folding.
setlocal foldmethod=indent  " Fold base on indentation.
setlocal foldnestmax=2  " Fold only one step in.
setlocal updatetime=1000  " Update swap file time.
setlocal encoding=utf-8  " Use an encoding that supports Unicode.
setlocal fileformat=unix  " File format setting.
setlocal wildignore=*.pyc

" Debuger insert mapping.
map <leader>d oimport pdb; pdb.set_trace() # BREAK POINT<ESC>
