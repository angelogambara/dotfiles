-- 1. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 3. Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Default to lazy-loading for speed
  defaults = { lazy = true },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    notify = false,
  },
  -- where events are defined.
  event = {
    -- This maps 'LazyFile' to the actual 'User LazyFile' event
    alias = {
      ["LazyFile"] = "User LazyFile",
    },
  },
})

-- Use the Gruvbox plugin
vim.cmd([[colorscheme gruvbox]])

-- 3. Load your basic settings AFTER lazy.nvim
require("config.autocmds")
require("config.keymaps")
require("config.options")
