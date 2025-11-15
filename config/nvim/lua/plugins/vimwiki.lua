return {
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          diary_rel_path = ".",
          path = "~/Documents/Diary/static",
          path_html = "~/Documents/Diary/public",
        },
      }
    end,
  },
}
