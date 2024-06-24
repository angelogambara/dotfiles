return {
  { "mbbill/undotree", lazy = false },
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
    event = 'BufWritePre',
  },
}
