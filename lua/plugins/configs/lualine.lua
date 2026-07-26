return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require("lualine")
    lualine.setup({
      options = {
        icons_enabled = true,
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = { statusline = 100 }, -- Force updates to refresh macros and recording status
      },
      sections = {
        lualine_c = {
          "aerial",
          function()
            return vim.fn.reg_recording() ~= "" and "⏺ Recording @" .. vim.fn.reg_recording() or ""
          end,
        },
      },
    })
  end
}
