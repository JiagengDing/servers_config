return {
	{
		"lambdalisue/suda.vim",
		cmd = 'SudaWrite',
	},
	{
		"folke/drop.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			math.randomseed(os.time())
			-- local theme = ({ "stars", "snow" })[math.random(1, 3)]
			require("drop").setup({ theme = "spring" })
		end,
	},
	{
		'glepnir/dashboard-nvim',
		enabled = false,
		event = 'VimEnter',
		config = function()
			require('dashboard').setup {
				theme = 'hyper',
				shortcut_type = 'number',
				hide = {
					statusline = true, -- hide statusline default is true
					tabline    = true, -- hide the tabline
					winbar     = true, -- hide winbar
				},
				config = {
					footer = { " ", " ", "Enjoy your life!" },
					project = { enable = false },
					mru = { limit = 4 },
					week_header = {
						enable = true,
					},
					shortcut = {
						{ desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
						{
							icon = ' ',
							icon_hl = '@variable',
							desc = 'Files',
							group = 'Label',
							action = 'Telescope find_files',
							key = 'f',
						},
						-- {
						-- 	desc = ' Apps',
						-- 	group = 'DiagnosticHint',
						-- 	action = 'Telescope app',
						-- 	key = 'a',
						-- },
						{
							desc = ' dotfiles',
							group = 'Number',
							action = 'Telescope dotfiles',
							key = 'd',
						},
					},
				},
			}
		end,
		dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	},
}
