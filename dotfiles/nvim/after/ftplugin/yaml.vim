" neovim yaml file type config
" Maintainer    Massoud Boorboor <boorboor@gmail.com>

setlocal expandtab  " Insert 'softtabstop' amount of space characters.
setlocal softtabstop=2  " Sets tab key width.
setlocal shiftwidth=2  " affects what happens when you press >>, << or ==.
setlocal colorcolumn=80,119,120  " Add a colored column to avoid going too far
setlocal signcolumn=yes:2  " draw sign column even no sign present.
setlocal foldcolumn=3  " draw sign column even no sign present.
setlocal updatetime=200  " Update swap file time.
setlocal encoding=utf-8  " Use an encoding that supports Unicode.
setlocal fileformat=unix  " File format setting.
setlocal shortmess+=c
