return {
  -- Base Copilot Plugin
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- Disable built-in ghost text suggestions to avoid conflicts with cmp
        suggestion = { enabled = false },
        panel = { enabled = false },
      }) end,
  },
  -- Copilot Source Integration for nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
