-- Define helper functions
local function map(mode, l, r, opts)  -- Make mappings
  vim.keymap.set(mode, l, r, opts)
end

project_files = function()  -- Git file search with fallback
  local opts = {}
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".fd(opts) end
end

-- Set configuration options
vim.opt.hidden = true  -- Lets leave unsaved buffers
vim.opt.confirm = true  -- Show confirmation message on buffer close.
vim.opt.autoread = true  -- Reads file if changed outside vim (triggered running command)

vim.opt.encoding = 'UTF-8'  -- Use Unicode encoding
vim.opt.fileformat = 'unix'  -- Use Unix file format, matter of new lines
vim.opt.spell = true -- Enables spell checker
vim.opt.spelllang = 'en_us'  -- Set spelling language

vim.opt.expandtab = true  -- Insert 'softtabstop' amount of space characters
vim.opt.softtabstop = 2  -- Sets tab key width
vim.opt.shiftwidth = 2  -- Affects what happens when you press >>, << or ==

vim.opt.termguicolors = true  -- Enables true colors
vim.opt.signcolumn = 'yes:3'  -- Draw sign columns even with on sign presence
vim.opt.number = true  -- Show line numbers
vim.opt.numberwidth = 4  -- Fix number column width
--vim.opt.colorcolumn = '120'  -- Add a colored column to avoid going to far
--vim.opt.cursorline = true  -- Highlight cursor line
vim.opt.shortmess = vim.opt.shortmess + 'c'  -- Use short form message

vim.opt.updatetime = 2000  -- Update swap file by `CursorHold` event or idea time in seconds
vim.opt.undofile = true  -- Enable persistent undo
vim.opt.undodir = os.getenv("HOME")..'/.cache/'  -- Enable persistent undo TODO: fix it
vim.opt.directory = vim.opt.directory ^ { os.getenv("HOME")..'/.cache/'}  -- Store `.swp` files
vim.opt.shadafile = os.getenv("HOME")..'/.cache/viminfo' -- Share data file store of sessions

vim.opt.listchars = {
  eol = '⏎',
  tab = '  ┊',
  trail = '•',
  extends = '…',
  precedes = '…',
  space = ' ',
}  -- Set none printable chars 

-- General key mappings
map('n', '<Space>l', '<CMD>set invlist<CR>')  -- Toggle `listchars` show
map('n', '<Space><Space>', '<CMD>Telescope<CR>')
map('n', '<Space>o', '<CMD>lua project_files()<CR>')
map('n', '<Space>g', '<CMD>Telescope live_grep<CR>')

map('v', '<C-c>', '"+y', { noremap=true })  -- Copy in visual mode into system clipboard
map('n', '<C-c>', '"+yy', { noremap=true })  -- Copy in normal mode into system clipboard
map('i', '<C-v>', '<Esc>"+pi', { noremap=true })  -- Paste in insert mode from system clipboard

map('n', ']q', '<CMD>cn<CR>')  -- Next quick list item
map('n', '[q', '<CMD>cp<CR>')  -- Previous quick list item

-- Plugin calls and configurations
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = {
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  'neovim/nvim-lspconfig',
  'navarasu/onedark.nvim',
  'nvim-treesitter/nvim-treesitter',
  'lewis6991/gitsigns.nvim',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'f3fora/cmp-spell',
  'hrsh7th/nvim-cmp',
  'numToStr/Comment.nvim',
  'boorboor/save.nvim',
}
require("lazy").setup(plugins, opts)

require('lualine').setup()  -- Set status line, use `nvim-lualine/lualine.nvim`

require('onedark').setup {
  transparent = true,  -- Make background transparent
  toggle_style_key = '<F3>',  -- key bind to toggle theme style
}
require('onedark').load()  -- Load color scheme, use `navarasu/onedark.nvim`

require('nvim-treesitter.configs').setup {  -- Use `nvim-treesitter/nvim-treesitter`
  ensure_installed = { 'lua', 'python', 'go', 'typescript', 'javascript' },  -- A list of parser names, or 'all'
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
}

require('gitsigns').setup {  -- Use `lewis6991/gitsigns.nvim`
  current_line_blame_formatter = '     <author>, <author_time:%R> - <summary>',
  on_attach = function()
    local gs = package.loaded.gitsigns
    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})
    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})
    map({'n', 'v'}, '<Space>hs', gs.stage_hunk)
    map({'n', 'v'}, '<Space>hr', gs.reset_hunk)
    map('n', '<Space>hu', gs.undo_stage_hunk)
    map('n', '<Space>hp', gs.preview_hunk)
    map('n', '<Space>hl', gs.toggle_current_line_blame)
    map('n', '<Space>hb', function() gs.blame_line{full=true} end)
    map('n', '<Space>hd', gs.diffthis)
    map('n', '<Space>hD', function() gs.diffthis('~') end)
    -- Text object
    map({'o', 'x'}, 'ih', gs.select_hunk)
  end
}

require('telescope').setup{  -- Use `nvim-telescope/telescope.nvim`
-- Use `BurntSushi/ripgrep` for live_grep
  defaults = {
    mappings = {
      n = {
        ['<C-k>'] = require('telescope.actions.layout').toggle_preview
      },
      i = {
        ['<C-k>'] = require('telescope.actions.layout').toggle_preview,
        ['<esc>'] = require('telescope.actions').close,
	-- ['<C-u>'] = false,
	["<C-s>"] = require('telescope.actions').cycle_previewers_next,
        ["<C-a>"] = require('telescope.actions').cycle_previewers_prev,
      },
    },
  },
  pickers = {
    builtin = { theme = 'dropdown', previewer = false, },
  },
}
require('telescope').load_extension('fzf')  -- Override the default file sorter

-- Language server configurations
local opts = { noremap=true, silent=true }
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  map('n', 'gD', vim.lsp.buf.declaration, bufopts)
  map('n', 'gd', vim.lsp.buf.definition, bufopts)
  map('n', 'gi', vim.lsp.buf.implementation, bufopts)
  map('n', 'gr', vim.lsp.buf.references, bufopts)
  map('n', 'K', vim.lsp.buf.hover, bufopts)
  map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  map('n', '<Space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  map('n', '<Space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  map('n', '<Space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  map('n', '<Space>d', vim.lsp.buf.type_definition, bufopts)
  map('n', '<Space>r', vim.lsp.buf.rename, bufopts)
  map('n', '<Space>a', vim.lsp.buf.code_action, bufopts)
  map('n', '<Space>f', vim.lsp.buf.formatting, bufopts)
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

--- sudo pip install 'python-lsp-server[all]'
require('lspconfig').pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- pip install ruff-lsp
require('lspconfig').ruff_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
-- npm install -g typescript-language-server
require('lspconfig').tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
-- Needs go toolkit
require('lspconfig').gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  --cmd = {"gopls", "serve"},
  --filetypes = {"go", "gomod"},
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
}
-- Rust setup, Run `rustup component add rust-analyzer`
require('lspconfig').rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {'rustup', 'run', 'stable', 'rust-analyzer'},
};

local cmp = require('cmp');
cmp.setup{  -- Use `hrsh7th/nvim-cmp`
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Use `L3MON4D3/LuaSnip`
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },  -- Use `hrsh7th/cmp-nvim-lsp`
    { name = 'spell' },  -- Use `f3fora/cmp-spell.git`
    { name = 'luasnip' },  -- `saadparwaiz1/cmp_luasnip`
    { name = 'buffer' },
  },
}

require('save').setup()  -- mini plugin Use `boorboor/save.nvim`

require('Comment').setup()  -- Use `numToStr/Comment.nvim`
