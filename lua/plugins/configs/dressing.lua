-- Styles vim.ui.input (rename, etc.) and vim.ui.select (code actions, etc.)
-- with a rounded border, matching Noice's cmdline/hover/signature popups.
return {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      border = "rounded",
      relative = "editor",
    },
    select = {
      builtin = {
        border = "rounded",
      },
    },
  },
}
