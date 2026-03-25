-------------------------------------------------------------------------------
-- GLOBAL VARIABLES & LEADERS
-------------------------------------------------------------------------------
-- Set leader keys before lazy.nvim or other plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Fix markdown indentation
vim.g.markdown_recommended_style = 0

-- Trouble/Lualine integration settings
vim.g.trouble_lualine = false

-------------------------------------------------------------------------------
-- PATH & DIRECTORY MANAGEMENT
-------------------------------------------------------------------------------
local runtime_dir = vim.env.XDG_RUNTIME_DIR
local shada_dir = runtime_dir .. "/nvim/shada"
local shada_file = shada_dir .. "/main.shada"
local undo_dir = runtime_dir .. "/nvim/undo"

-- Ensure directories exist
vim.fn.mkdir(shada_dir, "p", "0700")
vim.fn.mkdir(undo_dir, "p", "0700")

-------------------------------------------------------------------------------
-- EDITOR OPTIONS (vim.opt)
-------------------------------------------------------------------------------

-- UI and Appearance
vim.opt.cursorline = true       -- Highlight the current line
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true   -- Show relative line numbers
vim.opt.scrolloff = 4           -- Minimum lines to keep above/below cursor
vim.opt.sidescrolloff = 8       -- Minimum columns to keep to the left/right
vim.opt.signcolumn = "yes"      -- Always show the sign column (prevents flickering)
vim.opt.smoothscroll = true     -- Smooth scrolling for wrapped lines
vim.opt.termguicolors = true    -- Enable 24-bit RGB colors
vim.opt.updatetime = 200        -- Faster completion and diagnostic updates

-- Search and Case
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.wildmode = "longest:full,full"
vim.opt.ignorecase = true       -- Ignore case in search patterns
vim.opt.linebreak = true        -- Wrap lines at convenient points
vim.opt.list = true             -- Show invisible characters (tabs, trailing spaces)
vim.opt.smartcase = true        -- Override ignorecase if search contains capitals

-- Indentation and Tabs
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.shiftround = true       -- Round indent to multiple of shiftwidth
vim.opt.shiftwidth = 2          -- Size of an indent
vim.opt.smartindent = true      -- Insert indents automatically
vim.opt.tabstop = 2             -- Number of spaces tabs count for

-- Windows and Buffers
vim.opt.autowrite = true        -- Auto save before commands like :next and :make
vim.opt.splitbelow = true       -- Put new windows below current
vim.opt.splitright = true       -- Put new windows right of current
vim.opt.splitkeep = "screen"    -- Keep text in the same place when splitting

-- Folding (Code Organization)
vim.opt.foldlevel = 99          -- Open all folds by default
vim.opt.foldmethod = "indent"   -- Fold based on indentation levels
vim.opt.foldtext = ""           -- Use Neovim's default clean fold look

-- History and Persistence
vim.opt.shadafile = shada_file  -- Shared data file path (marks, history, etc.)
vim.opt.undodir = undo_dir      -- Directory for undo files
vim.opt.undofile = true         -- Save undo history to a file
vim.opt.undolevels = 10000      -- Maximum number of changes that can be undone

-- Clipboard
-- Use system clipboard if not in an SSH session
vim.opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"

-- Session options
-- Save these things from current session
vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "folds",
  "globals",
  "help",
  "skiprtp",
  "tabpages",
  "winsize",
}
