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
			})
			local function toggle_copilot_server()
				local client = vim.lsp.get_clients({ name = "copilot" })[1]
				local is_attached = client and client.attached_buffers[vim.api.nvim_get_current_buf()]

				if is_attached then
					vim.cmd("Copilot detach")
					vim.notify("Copilot Server: STOPPED (Detached)", vim.log.levels.WARN, { title = "Copilot" })
				else
					vim.cmd("Copilot attach")
					vim.notify("Copilot Server: STARTED (Attached)", vim.log.levels.INFO, { title = "Copilot" })
				end
			end

			vim.keymap.set("n", "<leader>cx", toggle_copilot_server,
				{ desc = "[COPILOT] Toggle Copilot Background Process" })
		end,
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
