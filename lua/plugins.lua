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
local lsp_servers = {
	"gopls",
	"tsserver",
	"eslint",
	"cssls",
	"bashls",
	"dockerls",
	"html",
	"htmx",
	"jsonls",
	"mdx_analyzer",
	"prismals",
	"jedi_language_server",
	"sqlls",
	"tailwindcss",
	"yamlls",
	"stylelint_lsp",
	"lua_ls"
}

-- mason and mason-lspconfig
local function configure_mason()
	require("mason").setup()
	require("mason-lspconfig").setup {
		ensure_installed = lsp_servers
	}
end

-- laspsaga config
local function configure_lspsaga()
	require('lspsaga').setup {}
end

-- nvim-treesitter
local function configure_treesitter()
	require('nvim-treesitter.configs').setup {
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm"
			}
		},
		indent = {
			enabled = true
		},
		highlight = {
			enabled = true
		},
		autotag = {
		 	enabled = true
		},
		textbjects = {
			select = {
				enabled = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				}
			},
			move = {
				enabled = true,
				set_jumps = true,
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer"
				}
			}
		},
		ensure_installed = "all"
	}
end

local function configure_nvim_tree()
	require('nvim-tree').setup {}
end

require('lazy').setup({
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{
				'williamboman/mason.nvim',
				config = configure_mason
			},
			'williamboman/mason-lspconfig.nvim',
			'folke/neodev.nvim',
			{
				'nvim-treesitter/nvim-treesitter',
				run = ':TSUpdate',
				config = configure_treesitter
			},
			'windwp/nvim-ts-autotag',
			{
				'kyazdani42/nvim-tree.lua',
				requires = 'kyazdani42/nvim-web-devicons',
				config = configure_nvim_tree
			},
			{
     				'nvimdev/lspsaga.nvim',
        			config = configure_lspsaga
      			}
		},
	}
})

-- LSP Server Configuration
local lspconfig = require('lspconfig')

-- Configure each LSP Server
for _, server in ipairs(lsp_servers) do
	lspconfig[server].setup{}
end

