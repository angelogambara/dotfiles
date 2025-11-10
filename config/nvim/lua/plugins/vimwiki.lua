return {
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          diary_index = "diary/index",
          index = "notes/index",
          path = "~/vimwiki/static",
          path_html = "~/vimwiki/public",
        },
      }
    end,
  },
}
