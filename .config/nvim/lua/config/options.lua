-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local runtime_dir = vim.env.XDG_RUNTIME_DIR
local shada_dir = runtime_dir .. "/nvim/shada"
local undo_dir = runtime_dir .. "/nvim/undo"
vim.fn.mkdir(shada_dir, "p", "0700")
vim.fn.mkdir(undo_dir, "p", "0700")
vim.opt.shadafile = shada_dir .. "/main.shada"
vim.opt.undofile = true
vim.opt.undodir = undo_dir
