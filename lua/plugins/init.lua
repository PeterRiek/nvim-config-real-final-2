-- Load lazy.nvim
-- adapted from https://github.com/LazyVim/starter
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")

if not ok then
  vim.api.nvim_echo({
    { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
    { out,                            "WarningMsg" },
    { "\nPress any key to exit..." },
  }, true, {})
  vim.fn.getchar()
  return
end

local theme = require("theme")
local enable_ai = os.getenv("NVIM_AI")

local plugins = {
  -- UI
  theme.get_active_theme(),                   -- Active theme configuration
  "folke/which-key.nvim",                     -- Which-Key shows key usage
  require("plugins.configs.treesitter"),      -- Treesitter parsing system
  require("plugins.configs.neotree"),         -- neo-tree file explorer
  require("plugins.configs.telescope"),       -- telescope fuzzyfinder
  require("plugins.configs.bufferline"),      -- bufferline tabpage
  require("plugins.configs.lualine"),         -- statusline
  require("plugins.configs.ufo"),             -- enhanced fold management
  require("plugins.configs.neoscroll"),       -- better scrolling
  require("plugins.configs.noice"),           -- popups and commandline centered popup
  require("plugins.configs.indentblankline"), -- Indent blankline for visual indentation guides
  { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } }, -- markdown rendering
  -- require("plugins.configs.iron"),					-- Interactive Repls
  "stevearc/dressing.nvim",                   -- cleaner popup interaction
  "folke/snacks.nvim",                        -- better popup interaction


  -- Utilities
  require("plugins.configs.maximizer"),     -- Toggle split max/min
  require("plugins.configs.autopairs"),     -- autoclose brackets, parentheses...
  require("plugins.configs.remote"),        -- Remote development support
  require("plugins.configs.gitsigns").spec, -- git integration
  require("plugins.configs.git-conflict"),  -- merge conflict resolution
  require("plugins.configs.todo-comments"), -- highlight and search TODO/FIXME/etc comments


  -- LSP/DAP
  "neovim/nvim-lspconfig",            -- collection of lsp server configs
  require("plugins.configs.mason"),   -- Package manager for LSP/DAP
  require("lsp.configs.java"),        -- Java language support
  require("plugins.configs.conform"), -- standalone formatters (prettier, etc.)


  -- Snippets
  require("plugins.configs.cmp"), -- cmp completion system

  -- Tmux - sync tmux and nvim
  -- (moving, resizing, clipboard, etc.)
  require("plugins.configs.tmux"), -- moving tmux panes <-> nvim splits

  -- AI & vibecode
  (function()
    if enable_ai then
      return
          require("plugins.configs.codecompanion"), -- ai chat companion
          require("plugins.configs.copilot")        -- ms copilot integration
    end
  end)()
}

lazy.setup(plugins)
