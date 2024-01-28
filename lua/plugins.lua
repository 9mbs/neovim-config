-- install lazy.nvim 
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
require('lazy').setup({
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{
				'williamboman/mason.nvim', 
				config = function()
					require("mason").setup()
					local servers = {
						"gopls",
						"tsserver",
						"eslint",
						"cssls",
						"bashls",
						"dockerls",
						"grammarly",
						"html",
						"htmx",
						"jsonls",
						"remark_ls",
						"mdx_analyzer",
						"prismals",
						"jedi_language_server",
						"sqlls",
						"tailwindcss",
						"yamlls",
						"stylelint_lsp"
					}
					require("mason-lspconfig").setup {
						ensure_installed = servers
					}		
				end
			},
			'williamboman/mason-lspconfig.nvim',
			'folke/neodev.nvim'
		},
	}
})

local lspconfig = require('lspconfig')

-- Configure servers
lspconfig.gopls.setup{}
lspconfig.tsserver.setup{}
lspconfig.eslint.setup{}
lspconfig.cssls.setup{}
lspconfig.bashls.setup{}
lspconfig.dockerls.setup{}
lspconfig.grammarly.setup{}
lspconfig.html.setup{}
lspconfig.htmx.setup{}
lspconfig.jsonls.setup{}
lspconfig.remark_ls.setup{}
lspconfig.mdx_analyzer.setup{}
lspconfig.prismals.setup{}
lspconfig.jedi_language_server.setup{} -- python?
lspconfig.sqlls.setup{}
lspconfig.tailwindcss.setup{}
lspconfig.yamlls.setup{}
lspconfig.stylelint_lsp.setup{}
