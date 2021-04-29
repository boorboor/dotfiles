" neovim python file type config
" Maintainer    Massoud Boorboor <boorboor@gmail.com>

setlocal noexpandtab " Insert 'softtabstop' amount of space characters.
setlocal softtabstop=8 " Sets tab key width.
setlocal shiftwidth=8 " Affects what happens when you press >>, << or ==.
setlocal showmatch  " Highlight pair parenthesis.
setlocal nowrap  " Disable line wrapping.
setlocal signcolumn=yes  " draw sign column even no sign present.
setlocal foldenable  " Enable folding.
setlocal foldmethod=syntax  " Fold base on indentation.
setlocal foldnestmax=2  " Fold only one step in.
setlocal updatetime=1000  " Update swap file time.
setlocal encoding=utf-8  " Use an encoding that supports Unicode.
setlocal fileformat=unix  " File format setting.
setlocal omnifunc=v:lua.vim.lsp.omnifunc
setlocal shortmess+=c
