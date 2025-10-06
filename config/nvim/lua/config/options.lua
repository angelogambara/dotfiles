-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Get runtime dir (usually /run/user/$UID)
local runtime_dir = vim.env.XDG_RUNTIME_DIR or "/tmp"

-- Declare isdirectory paths
local shada_dir = runtime_dir .. "/nvim/shada"
local undo_dir = runtime_dir .. "/nvim/undo"

-- Create directories if they don't exist
local function ensure_dir(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p", "0700")
  end
end

ensure_dir(shada_dir)
ensure_dir(undo_dir)

-- Set Neovim options
vim.opt.shadafile = shada_dir .. "/main.shada"
vim.opt.undodir = undo_dir
vim.opt.undofile = true
