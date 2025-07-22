-- lua/plugins/java.lua

return {
  -- 1. Install the plugin
  "nvim-java/nvim-java",
  dependencies = {
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
  },
  ft = "java",
  config = function()
    -- 2. Setup nvim-java before lspconfig
    require("java").setup()

    -- 3. Setup jdtls like you would usually do
    require("lspconfig").jdtls.setup({})
  end,
}
