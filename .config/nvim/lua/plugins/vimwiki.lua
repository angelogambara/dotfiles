return {
  "vimwiki/vimwiki",
  keys = {
    -- 1. Navigation
    { "<leader>ww", desc = "VimWiki Index" },
    { "<leader>wi", desc = "VimWiki Diary Index" },
    { "<leader>wt", desc = "VimWiki Tab New" },

    -- 2. Generation
    { "<leader>w<leader>i", desc = "VimWiki Diary Generate Links" },
    { "<leader>w<leader>w", desc = "VimWiki Make Diary Note" },
    -- { "<leader>w<leader>t", desc = "VimWiki Make Tomorrow Diary Note" },
    -- { "<leader>w<leader>y", desc = "VimWiki Make Yesterday Diary Note" },

    -- 3. Flipping pages
    -- { "<leader>w<leader>n", desc = "VimWiki Diary Next Day" },
    -- { "<leader>w<leader>p", desc = "VimWiki Diary Prev Day" },

    -- 4. Management
    -- { "<leader>wd", desc = "VimWiki Delete File" },
    -- { "<leader>wr", desc = "VimWiki Rename File" },
  },
  init = function()
    vim.g.vimwiki_list = {
      {
        diary_rel_path = ".",
        path = "~/diary",
        syntax = "markdown",
        ext = ".md",
      },
    }
    -- Optional: prevents VimWiki from treating all markdown files as wikis
    vim.g.vimwiki_global_ext = 0
  end,
}
