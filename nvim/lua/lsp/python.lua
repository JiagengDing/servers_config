return {
	setup = function(lspconfig, lsp)
		lspconfig.pylsp.setup({
			on_attach = function()
			end,
		})
		lspconfig.pylsp.settings = {
			{
				pylsp = {
					plugins = {
						pycodestyle = {
							ignore = { 'W391' },
							maxLineLength = 100
						}
					}
				}
			}
		}
	end
}
