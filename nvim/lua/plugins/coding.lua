return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end
	},
	{
		"godlygeek/tabular",
		cmd = { "Tabularize" },
	},
	{
		"gcmt/wildfire.vim",
		keys = { "<enter>", "<cmd>call wildfire#visual_expand()<cr>" },
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "BufRead",
		dependencies = { "kevinhwang91/promise-async", },
		config = function() require('ufo').setup() end
	},
	{
		"pechorin/any-jump.vim",
		event = "BufRead",
		config = function()
			vim.keymap.set("n", "j", ":AnyJump<CR>", { noremap = true })
			vim.keymap.set("x", "j", ":AnyJumpVisual<CR>", { noremap = true })
			vim.g.any_jump_disable_default_keybindings = true
			vim.g.any_jump_window_width_ratio = 0.9
			vim.g.any_jump_window_height_ratio = 0.9
		end
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>F",
				mode = "n",
				function()
					require("spectre").open()
				end,
				desc = "Project find and replace"
			}
		}
	},
}
