local M = {}

local term_buf = nil

function M.toggle_split()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    local win = vim.fn.bufwinid(term_buf)
    if win ~= -1 then
      vim.api.nvim_win_close(win, false)
      return
    end
    vim.cmd("split")
    vim.api.nvim_win_set_buf(0, term_buf)
    vim.cmd("startinsert")
    return
  end

  vim.cmd("split | terminal")
  term_buf = vim.api.nvim_get_current_buf()
  vim.cmd("startinsert")
end

return M
