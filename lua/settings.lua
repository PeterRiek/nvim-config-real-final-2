local options = {
  shiftwidth = 4,
  tabstop = 4,

  clipboard = "unnamed,unnamedplus",                 -- Use system clipboard

  ignorecase = true,                                 -- Case insensitive search UNLESS /C or capital in search

  undodir = os.getenv("HOME") .. "/.vim/undidir",    -- store undos in ~/.vim/undidir/
  undofile = true,                                   -- save undo history

  number = true,                                     -- Make line numbers default
  relativenumber = true,                             -- Make relative line numbers default
  signcolumn = "yes",                                -- Always show the sign column, otherwise it would shift the text each time
  statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum} ", -- Show relative line numbers in the status column
  scrolloff = 3,                                     -- keep 3 lines at bottom on scrolling
  cursorline = true,

  foldenable = false,
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevel = 99,
  foldlevelstart = 99,
  foldmethod = "expr",

  splitright = true,
  splitbelow = true,

  winborder = "rounded",                              -- default border style for floating windows (nvim-cmp, LSP floats, etc.)
}

-- temporary disable deprecation warnings
vim.deprecate = function() end

for key, value in pairs(options) do
  vim.opt[key] = value
end

-- UI theme
require("theme").set_active_theme("onedarkpro")
