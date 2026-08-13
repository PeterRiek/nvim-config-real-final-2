-- conform.nvim: run standalone formatters (prettier, etc.) where LSP formatting
-- is missing or weak. <leader>af falls back to LSP formatting for filetypes
-- with no formatter configured here.
return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        vue = { "prettier" },
      },
    })
  end,
}
