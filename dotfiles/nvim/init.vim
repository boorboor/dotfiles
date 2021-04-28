" neovim config file
" Maintainer    Massoud Boorboor <boorboor@gmail.com>
" Last Change   Wed 28 Apr 2021 09:24:44 PM

set number  " Show line numbers in side bar for better navigation.
set termguicolors  " Enable true colors for more colors.
set linebreak " Avoid wrapping a line in the middle of a word.
set textwidth=119 " Set max line width to 119(github page) for easy review.
set viminfo+=n~/.cache/vim/viminfo " Puts .viminfo file into .cache/vim/ Dir.
set directory^=$HOME/.cache// " Directory to store .swp files.
set listchars=eol:⏎,tab:\ \ ┊,trail:•,extends:…,precedes:…,space:⎵  " None printables

colorscheme gruvbox
highlight TrailingSpaceChar ctermbg=1
highlight TabChar ctermbg=1
syn match TrailingSpaceChar " *$"
syn match TabChar "\t"

filetype indent plugin on
syntax enable

" Open list of buffers and wait for index number to jump.
nnoremap gb :ls<cr>:b<space> 
" Enable spell check
map <leader>s :setlocal spell! spelllang=en_us<CR>
" Show placeholders for non printable characters
map <leader>l :set invlist<cr>
