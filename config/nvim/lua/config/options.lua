-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.shadafile = os.getenv("XDG_RUNTIME_DIR") .. "/nvim/shada/main.shada"
vim.o.undodir = os.getenv("XDG_RUNTIME_DIR") .. "/nvim/undo"
