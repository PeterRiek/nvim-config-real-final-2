-- nvim-cmp is a completion engine for Neovim that provides context-aware suggestions while you type.
-- It supports sources from LSP, snippets, buffers, paths, and more, allowing flexible autocompletion.
-- Highly extensible and configurable, it lets you customize key mappings, sorting, and formatting of completion items.
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "zbirenbaum/copilot-cmp",             -- CHANGED: Swapped out broken hrsh7th/cmp-copilot for zbirenbaum version
    "hrsh7th/cmp-nvim-lsp",               -- Adds Language Server Protocol (LSP) completions
    "hrsh7th/cmp-nvim-lua",               -- Provides Neovim Lua API completions (useful for Lua configs)
    "hrsh7th/cmp-buffer",                 -- Enables buffer-based completions from current file
    "hrsh7th/cmp-path",                   -- Adds filesystem path completions
    "hrsh7th/cmp-cmdline",                -- Provides completion in Neovim's command line (: commands, / search)
    "hrsh7th/cmp-nvim-lsp-document-symbol", -- Offers LSP document symbol completions (functions, classes, variables)
    "L3MON4D3/LuaSnip",                   -- Snippet engine for inserting reusable code snippets
    "saadparwaiz1/cmp_luasnip",           -- Integrates LuaSnip snippets into nvim-cmp completion menu
    "lukas-reineke/cmp-under-comparator", -- Improves sorting of completion items starting with underscores (e.g., Python)	},
    "onsails/lspkind.nvim",               -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Ensure copilot-cmp initializes its internal handlers properly
    require("copilot_cmp").setup()

    -- Set up the explicit visual styling for the ghost text overlay
    -- This links the ghost text color to your theme's default comment color (typically dark gray/faded)
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    -- require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(),    -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "copilot",  group_index = 2 }, -- ms copilot
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip",  group_index = 2 }, -- snippets
        { name = "buffer",   group_index = 2 }, -- text within current buffer
        { name = "path",     group_index = 2 }, -- file system paths
      }),
      -- customize the window the suggestions appear in
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = "symbol",
          maxwidth = 50,
          ellipsis_char = "...",
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
          -- Integrates custom icon for Copilot inside lspkind
          symbol_map = { Copilot = "" }
        }),
      },
      -- limit to max 20 entries
      performance = {
        max_view_entries = 20,
      },
      -- CHANGED: Added experimental ghost text parameters
      experimental = {
        ghost_text = function()
          local context = require("cmp.config.context")
          -- Disable ghost text if your cursor is inside a comment block
          if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
            return false
          end
          return { hl_group = "CmpGhostText" }
        end,
      },
    })
  end,
}
