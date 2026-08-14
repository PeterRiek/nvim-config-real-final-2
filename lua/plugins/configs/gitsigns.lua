local M = {}

M.spec = {
  "lewis6991/gitsigns.nvim"
}

-- Gitsigns diffthis only opens a diff split; it won't close one, so close
-- the diff window(s) ourselves when toggling off.
function M.toggle_diffthis()
  if vim.wo.diff then
    local cur_win = vim.api.nvim_get_current_win()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if win ~= cur_win and vim.wo[win].diff then
        vim.api.nvim_win_close(win, false)
      end
    end
  else
    vim.cmd("Gitsigns diffthis")
  end
end

return M
