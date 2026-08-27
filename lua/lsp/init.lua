local capabilities = require("lsp.handlers").capabilities

-- LUA setup
vim.lsp.config("lua_ls", {
  autostart = false,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.enable("lua_ls")

-- C setup
vim.lsp.config("clangd", {
  -- capabilities = capabilities,
})
vim.lsp.enable("clangd")

-- Python setup
vim.lsp.config('ruff', {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
})
vim.lsp.enable('ruff')

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",

        reportMissingImports = "error",

        reportMissingTypeStubs = false,

        diagnosticSeverityOverrides = {
          reportAssignmentType = "warning",

          reportUnknownMemberType = "none",
          reportUnknownVariableType = "none",
          reportUnknownArgumentType = "none",
          reportUnknownParameterType = "none",
          reportAny = "none",

          reportUntypedFunctionDecorator = "none",
          reportUntypedClassDecorator = "none",
          reportUntypedBaseClass = "none",

          reportUnusedImport = "none",
          reportUnusedVariable = "none",
          reportUndefinedVariable = "none",
        },
      }
    }
  },
  handlers = {
    ["$/progress"] = function() end,
  }
})
vim.lsp.enable("basedpyright")

-- TypeScript / JavaScript setup (corrected from ls_ts)
vim.lsp.config("ts_ls", {
  -- capabilities = capabilities,
})
vim.lsp.enable("ts_ls")

-- CMake setup
vim.lsp.config("cmake", {
  -- capabilities = capabilities,
})
vim.lsp.enable("cmake")

-- Dart setup (utilizing the built-in Dart SDK language server)
vim.lsp.config("dartls", {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  init_options = {
    closinglabels = true,
    flutteroutline = true,
    onlyanalyzeprojectswithopenfiles = true,
    outline = true,
    suggestfromunimportedlibraries = true,
  },
})
vim.lsp.enable("dartls")

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
})
