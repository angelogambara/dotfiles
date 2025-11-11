return {
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki/static",
          path_html = "~/vimwiki/public",
          index = "notes/notes",
        },
      }
    end,
  },
}
