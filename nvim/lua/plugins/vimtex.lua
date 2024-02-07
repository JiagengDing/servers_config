return {
	'lervag/vimtex',
	ft = { 'tex' },
	config = function()
		vim.g.vimtex_view_method = 'zathura'
		vim.g.vimtex_mappings_enabled = 0
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_compiler_progname = 'xelatex'
		vim.g.vimtex_compiler_latexmk = {
			executable = 'latexmk',
			options = {
				'-shell-escape',
				'-verbose',
				'-file-line-error',
				'-synctex=1',
				'-interaction=nonstopmode',
			},
		}
	end,
}
