" neovim config file
" Maintainer    Massoud Boorboor <boorboor@gmail.com>
" Last Change   Wed 28 Apr 2021 09:24:44 PM

set number  " Show line numbers in side bar for better navigation.
set autoread
set hidden
set termguicolors  " Enable true colors for more colors.
set linebreak " Avoid wrapping a line in the middle of a word.
set textwidth=119 " Set max line width to 119(github page) for easy review.
set viminfo+=n~/.cache/vim/viminfo " Puts .viminfo file into .cache/vim/ Dir.
set directory^=$HOME/.cache// " Directory to store .swp files.
set listchars=eol:⏎,tab:\ \ ┊,trail:•,extends:…,precedes:…,space:⎵  " None printables
set confirm  " Show confirmation message on buffer leave.

set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\           	  " buffer number
set statusline+=%#Visual#       	  " color
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#     	  " color
set statusline+=%R                        " read only flag
set statusline+=%M                        " modified [+] flag
set statusline+=%#CursorLine#   	  " color
set statusline+=%=                        " right align
set statusline+=%#CursorLine#   	  " color
set statusline+=\ %Y\                     " file type
set statusline+=%#CursorIM#               " color
set statusline+=\ %f:%l:%-2c\             " line + column
set statusline+=%#Cursor#                 " color
set statusline+=\ %3p%%\                  " percentage

colorscheme gruvbox
highlight TrailingTabSpaceChar ctermbg=red guibg=red
syn match TrailingTabSpaceChar "*$"
syn match TrailingTabSpaceChar "\t"

filetype indent plugin on
syntax enable

" Open list of buffers and wait for index number to jump.
nnoremap gb :ls<cr>:b<space>
" Enable spell check
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>
" Show placeholders for non printable characters
nnoremap <leader>l :set invlist<cr>

" Find files using Telescope command-line sugar, Using lua functions.
nnoremap <leader>o <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>

" Language server protocol, Servers setup.
lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>el', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guifg=DarkGray
      hi LspReferenceText cterm=bold ctermbg=red guifg=DarkGray
      hi LspReferenceWrite cterm=bold ctermbg=red guifg=DarkGray
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Setup servers.
nvim_lsp['pyls'].setup { on_attach = on_attach }
nvim_lsp['vimls'].setup { on_attach = on_attach }
nvim_lsp['yamlls'].setup{ on_attach = on_attach }
nvim_lsp['gopls'].setup { on_attach = on_attach,
  cmd = {"gopls", "serve"},
    settings = {
      gofumpt = true,
      usePlaceholders = true,
      gopls = {
        codelenses = {
          generat = true,
          gc_detail = true
	},
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}
EOF
