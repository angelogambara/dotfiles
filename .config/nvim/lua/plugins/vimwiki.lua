return {
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          diary_rel_path = ".",
          path = "~/diary",
        },
      }
    end,
  },
}
