return {
  -- Add the Catppuccin plugin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Ensure it loads before other plugins
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      term_colors = true,
      integrations = {
        telescope = true,
        neotree = true,
        which_key = true,
        -- Add other integrations as needed
      },
    },
  },

  -- Set LazyVim to use Catppuccin as the default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
