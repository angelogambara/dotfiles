require "nvchad.options"
require "os"

-- add yours here!

if os.getenv("USER") == "root" then
  vim.o.undofile = false
end

vim.o.relativenumber = true
vim.o.spelllang = "en,it"
vim.o.shadafile = "/run/user/1000/nvim/shada/main.shada"
