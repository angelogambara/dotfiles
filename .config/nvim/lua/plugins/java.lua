return {
  -- 1. Configure nvim-java FIRST
  {
    "nvim-java/nvim-java",
    -- config = false, -- Only use this if you want to call .setup() manually below
    opts = {
      jdk = {
        auto_install = false, -- Stops the JDK 25 download
      },
      jdtls = {
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-21",
                  path = "/usr/lib/jvm/java-21-openjdk",
                  default = true,
                },
              },
            },
          },
        },
      },
    },
  },
  -- 2. Hook into LazyVim's LSP setup
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        -- This is the recommended way to bridge nvim-java with LazyVim
        jdtls = function()
          require("java").setup()
          return false -- Tells LazyVim to use nvim-java's jdtls instead of the default
        end,
      },
    },
  },
}
