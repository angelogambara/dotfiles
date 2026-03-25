local map = vim.keymap.set

-- =============================================================================
-- NAVIGATION & WINDOWS
-- =============================================================================

-- Better up/down (handles wrapped lines unless a count is given)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move between windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Window management
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- =============================================================================
-- BUFFERS & TABS
-- =============================================================================

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Buffer deletion
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })

-- =============================================================================
-- EDITING & INTENT
-- =============================================================================

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Save & Global actions
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Formatting & Coding
map({ "n", "x" }, "<leader>cf", function()
  require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
end, { desc = "Format" })

map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Better Indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- =============================================================================
-- SEARCH & DIAGNOSTICS
-- =============================================================================

-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  if vim.snippet and vim.snippet.active() then vim.snippet.stop() end
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Saner search behavior (keeps result centered)
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })

-- Diagnostics navigation
local diag_jump = function(next, severity)
  return function()
    vim.diagnostic.jump({ count = (next and 1 or -1) * vim.v.count1, severity = severity and vim.diagnostic.severity[severity] or nil, float = true })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diag_jump(true), { desc = "Next Diagnostic" })
map("n", "[d", diag_jump(false), { desc = "Prev Diagnostic" })
map("n", "]e", diag_jump(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diag_jump(false, "ERROR"), { desc = "Prev Error" })

-- Lists
map("n", "<leader>xl", function()
  local is_open = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
  vim.cmd(is_open and "lclose" or "lopen")
end, { desc = "Toggle Location List" })

map("n", "<leader>xq", function()
  local is_open = vim.fn.getqflist({ winid = 0 }).winid ~= 0
  vim.cmd(is_open and "cclose" or "copen")
end, { desc = "Toggle Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- =============================================================================
-- SNACKS & TOOLS
-- =============================================================================

-- Git
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function() Snacks.lazygit({ cwd = Snacks.git.get_root() }) end, { desc = "Lazygit (Root)" })
  map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
end
map("n", "<leader>gl", function() Snacks.picker.git_log({ cwd = Snacks.git.get_root() }) end, { desc = "Git Log" })
map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (Open)" })

-- Terminal
map({ "n", "t" }, "<c-/>", function() Snacks.terminal(nil, { cwd = Snacks.project.root() }) end, { desc = "Terminal (Root)" })
map({ "n", "t" }, "<c-_>", function() Snacks.terminal(nil, { cwd = Snacks.project.root() }) end, { desc = "which_key_ignore" })

-- UI Toggles
-- stylua: ignore start
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.scroll():map("<leader>uS")
Snacks.toggle.zen():map("<leader>uz")
Snacks.toggle.zoom():map("<leader>wm")
if vim.lsp.inlay_hint then Snacks.toggle.inlay_hints():map("<leader>uh") end
-- stylua: ignore end

-- =============================================================================
-- AUTOCOMMANDS / LANGUAGE SPECIFIC
-- =============================================================================

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    map({ "n", "x" }, "<localleader>r", function() Snacks.debug.run() end, { desc = "Run Lua", buffer = true })
  end,
})
