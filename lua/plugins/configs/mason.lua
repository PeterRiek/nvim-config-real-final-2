return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Lua-Language-Server
          -- issue wih lua_ls version >= 3.16.0
          -- see https://neuralinsights-tar.netlify.app/?page=en-git-zed-extensions-lua-1764823019456
          "lua_ls@3.15.0",
          -- C language server
          "clangd",
          -- Python language server
          "basedpyright",
          "ruff",
          -- Java language server
          "jdtls",
          -- Typescript Javascript
          "ts_ls",
        },
        automatic_enable = {
          exclude = {
            "jdtls",
            -- vue_ls needs to run as a plugin inside ts_ls/vtsls (hybrid mode)
            -- rather than standalone; not wired up since we only need formatting.
            "vue_ls",
          }
        }
      })
    end
  }
}
