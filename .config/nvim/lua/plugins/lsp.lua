return {
  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    priority = 1000,
    dependencies = {
      { 'saghen/blink.cmp', version = '1.*' },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local lspconfig = require('lspconfig')
      
      -- 1. Setup Mason first
      require("mason").setup()

      -- 2. Setup Blink (Must be before LSP configs to provide capabilities)
      require('blink.cmp').setup({
        keymap = { preset = 'default' },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = 'mono'
        },
        completion = {
          menu = {
            min_width = 30,
            max_height = 10,
            border = "rounded", -- Optional: adds a nice border to the menu
          },
          documentation = {
            auto_show = true,
            window = { border = "rounded" },
          },
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
      })

      -- Get capabilities after blink is set up
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- 3. Setup Mason-LSPConfig
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd", "bashls", "gopls", "pyright",
          "marksman", "html", "cssls", "vtsls", "sqls",
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            local opts = { capabilities = capabilities }
            lspconfig[server_name].setup(opts)
          end,
        },
      })
    end,
  },
}
