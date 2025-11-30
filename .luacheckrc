std = "luajit"

globals = {
    "vim",        -- The main Neovim API
    "Snacks",     -- Used in your keymaps.lua
    "jit",        -- LuaJIT specific
    "bit",        -- LuaJIT specific
}

ignore = {
    "631", -- "Line is too long" (Config lines often get long, it's fine)
    "212", -- "Unused argument" (Very common in callbacks, e.g. on_attach(client, bufnr))
    "213", -- "Unused loop variable"
    "113", -- "Accessing undefined variable" (We trust the globals list above)
}

files["**/spec/**/*"] = {
    globals = { "describe", "it", "before_each", "after_each", "setup", "teardown" }
}
