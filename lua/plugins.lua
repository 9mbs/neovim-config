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

local lsp_servers = {
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
	"stylelint_lsp",
	"lua_ls"
}

local function configure_mason()
	require("mason").setup()
	require("mason-lspconfig").setup {
		ensure_installed = servers
	}
end

-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
require('lazy').setup({
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{
				'williamboman/mason.nvim', 
				config = configure_mason
			},
			'williamboman/mason-lspconfig.nvim',
			'folke/neodev.nvim'
		},
	}
})

-- LSP Server Configuration
local lspconfig = require('lspconfig')

-- Configure each LSP Server
for _, server in ipairs(lsp_servers) do
	lspconfig[server].setup{}
end

