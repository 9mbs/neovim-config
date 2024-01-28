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

-- Configure the gopls server
lspconfig.gopls.setup({
	on_attach = function(client, bufnr) 
		-- Enable completion triggered by <ctrl-x><ctrl-o>
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

		-- Key mappings for LSP functions 
		local opts = { noremap=true, silent=true }
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
		
		-- Add more keybindings as needed

		-- TODO: Setup autocompletion with `nvim-cmp` or another completion plugi
	end

})
