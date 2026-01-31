return {
  "vimwiki/vimwiki",
  -- Trigger lazy-loading
  keys = { "<leader>ww", "<leader>wt" },
  init = function()
    vim.g.vimwiki_list = {
      {
        diary_rel_path = ".", -- I only care about diary
        path = "~/diary", -- Change to your desired path
        syntax = "markdown", -- Use markdown syntax instead of default
        ext = ".md",
      },
    }
    -- Optional: prevents Vimwiki from treating all markdown files as wikis
    vim.g.vimwiki_global_ext = 0
  end,
}
