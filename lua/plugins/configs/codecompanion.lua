-- AI assistant coding
-- adapters will look in your environment for a *_API_KEY where * is the name of the adapter
return {
	'olimorris/codecompanion.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-treesitter/nvim-treesitter',
		'j-hui/fidget.nvim',
		{ 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
	},
	config = function()
		local status, secrets = pcall(require, 'secrets')
		if status and secrets.gemini_api_key then
			vim.env.GEMINI_API_KEY = secrets.gemini_api_key
		end
		require('codecompanion').setup {
			display = {
				chat = {
					window = {
						layout = "vertical",
						position = "right"
					}
				}
			},
			adapters = {
				gemini = require('codecompanion.adapters').extend('gemini', {
					schema = {
						model = {
							default = 'gemini-2.5-flash',
						},
					},
				}),
				http = {
					ollama = function ()
						return require('codecompanion.adapters').extend('ollama', {
							env = {
								url = 'http://100.111.209.1:11434',
							},
							schema = {
								model = { default = 'qwen2.5-coder:3b' },
								num_ctx = { default = 8000 },
							},
						})
					end
				}
			},
			strategies = {
				chat = {
					adapter = 'ollama',
				},
				inline = {
					adapter = 'ollama',
				},
			}
		}

		-- Fidget status of prompt progress
		local progress = require("fidget.progress")
		local handles = {}
		local group = vim.api.nvim_create_augroup("CodeCompanionFidget", {})
		vim.api.nvim_create_autocmd("User", {
			pattern = "CodeCompanionRequestStarted",
			group = group,
			callback = function(e)
				handles[e.data.id] = progress.handle.create({
					title = "CodeCompanion",
					message = "Thinking...",
					lsp_client = { name = e.data.adapter.formatted_name }
				})
			end
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "CodeCompanionRequestFinished",
			group = group,
			callback = function(e)
				local h = handles[e.data.id]
				if not h then return end
				h.message = e.data.status == "success" and "Done" or "Failed"
				h:finish()
				handles[e.data.id] = nil
			end
		})
	end,
}
