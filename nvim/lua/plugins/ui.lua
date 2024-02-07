return {
	{
		"nvim-lualine/lualine.nvim",
		event = "UiEnter",
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = 'auto',
					component_separators = { left = '', right = '' },
					section_separators = { left = '', right = '' },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					}
				},
				sections = {
					lualine_a = { 'filename' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = {},
					lualine_x = {},
					lualine_y = { 'filesize', 'fileformat', 'filetype' },
					lualine_z = { 'location' }
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = { 'location' },
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {}
			}
		end
	},
	{
		'akinsho/bufferline.nvim',
		event = "BufRead",
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = {
				mode = "tabs",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				indicator = {
					icon = '▎', -- this should be omitted if indicator style is not 'icon'
					-- style = 'icon' | 'underline' | 'none',
					style = "icon",
				},
				show_buffer_close_icons = false,
				show_close_icon = false,
				enforce_regular_tabs = true,
				show_duplicate_prefix = false,
				tab_size = 16,
				padding = 0,
				separator_style = "thick",
			}
		}
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local header = [[
			      _ ___    _    ____ _____ _   _  ____
			     | |_ _|  / \  / ___| ____| \ | |/ ___|          h
			  _  | || |  / _ \| |  _|  _| |  \| | |  _        h
			 | |_| || | / ___ \ |_| | |___| |\  | |_| |    h
			  \___/|___/_/   \_\____|_____|_| \_|\____| h
			]]
			dashboard.section.header.val = vim.split(header, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				-- dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				-- dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("p", "󰒲 " .. " Lazy profile", ":Lazy profile<CR>"),
				-- dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = true,
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			-- "MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true,    -- use a classic bottom cmdline for search
					command_palette = true,  -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false,      -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false,  -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			{
				plugins = {
					marks = true, -- shows a list of your marks on ' and `
					registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
					-- the presets plugin, adds help for a bunch of default keybindings in Neovim
					-- No actual key bindings are created
					spelling = {
						enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
						suggestions = 20, -- how many suggestions should be shown in the list?
					},
					presets = {
						operators = false, -- adds help for operators like d, y, ...
						motions = false, -- adds help for motions
						text_objects = true, -- help for text objects triggered after entering an operator
						windows = true, -- default bindings on <c-w>
						nav = true,    -- misc bindings to work with windows
						z = true,      -- bindings for folds, spelling and others prefixed with z
						g = true,      -- bindings for prefixed with g
					},
				},
				-- add operators that will trigger motion and text object completion
				-- to enable all native operators, set the preset / operators plugin above
				operators = { gc = "Comments" },
				key_labels = {
					-- override the label used to display some keys. It doesn't effect WK in any other way.
					-- For example:
					-- ["<space>"] = "SPC",
					-- ["<cr>"] = "RET",
					-- ["<tab>"] = "TAB",
				},
				motions = {
					count = true,
				},
				icons = {
					breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
					separator = "➜", -- symbol used between a key and it's label
					group = "+", -- symbol prepended to a group
				},
				popup_mappings = {
					scroll_down = "<c-d>", -- binding to scroll down inside the popup
					scroll_up = "<c-u>", -- binding to scroll up inside the popup
				},
				window = {
					border = "none",     -- none, single, double, shadow
					position = "bottom", -- bottom, top
					margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
					padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
					winblend = 0,        -- value between 0-100 0 for fully opaque and 100 for fully transparent
					zindex = 1000,       -- positive value to position WhichKey above other floating windows.
				},
				layout = {
					height = { min = 4, max = 25 },                                             -- min and max height of the columns
					width = { min = 20, max = 50 },                                             -- min and max width of the columns
					spacing = 3,                                                                -- spacing between columns
					align = "left",                                                             -- align columns left, center or right
				},
				ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
				hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
				show_help = true,                                                             -- show a help message in the command line for using WhichKey
				show_keys = true,                                                             -- show the currently pressed key and its label as a message in the command line
				triggers = "auto",                                                            -- automatically setup triggers
				-- triggers = {"<leader>"} -- or specifiy a list manually
				-- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
				triggers_nowait = {
					-- marks
					"`",
					"'",
					"g`",
					"g'",
					-- registers
					'"',
					"<c-r>",
					-- spelling
					"z=",
				},
				triggers_blacklist = {
					-- list of mode / prefixes that should never be hooked by WhichKey
					-- this is mostly relevant for keymaps that start with a native binding
					i = { "j", "k" },
					v = { "j", "k" },
				},
				-- disable the WhichKey popup for certain buf types and file types.
				-- Disabled by default for Telescope
				disable = {
					buftypes = {},
					filetypes = {},
				},
			}
		}
	},
}
