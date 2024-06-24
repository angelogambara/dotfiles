require "nvchad.mappings"

-- add yours here!

local map = vim.keymap.set

for i = 1, 9, 1 do
  map("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

map("n", "<A-t>", function()
  require("base46").toggle_transparency()
end)

map("n", "<A-h>", ":nohlsearch<CR>")
map("n", "<A-u>", ":UndotreeToggle<CR>")
