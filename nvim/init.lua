-- ▄▀▀▀▀▄   ▄▀▀▄▀▀▀▄  ▄▀▀▀█▀▀▄  ▄▀▀█▀▄   ▄▀▀▀▀▄   ▄▀▀▄ ▀▄  ▄▀▀▀▀▄ 
--█      █ █   █   █ █    █  ▐ █   █  █ █      █ █  █ █ █ █ █   ▐ 
--█      █ ▐  █▀▀▀▀  ▐   █     ▐   █  ▐ █      █ ▐  █  ▀█    ▀▄   
--▀▄    ▄▀    █         █          █    ▀▄    ▄▀   █   █  ▀▄   █  
--  ▀▀▀▀    ▄▀        ▄▀        ▄▀▀▀▀▀▄   ▀▀▀▀   ▄▀   █    █▀▀▀   
--         █         █         █       █         █    ▐    ▐      
--         ▐         ▐         ▐       ▐         ▐                

-- @diagnostic disable: undefined-global
-- line nums
vim.opt.number = true

-- relative line nums
vim.opt.relativenumber = true

-- 24-bit color
vim.opt.termguicolors = true

-- space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- check leader
vim.keymap.set('n', '<leader>t', ':echo "Hola, Mundo!"<CR>')

-- num of spaces a <Tab> counts for
vim.opt.tabstop = 2

-- num of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2

-- convert tabs to spaces
vim.opt.expandtab = true

-- ▄▀▀▀▀▄      ▄▀▀█▄   ▄▀▀▀▀▄   ▄▀▀▄ ▀▀▄ 
--█    █      ▐ ▄▀ ▀▄ █     ▄▀ █   ▀▄ ▄▀ 
--▐    █        █▄▄▄█ ▐ ▄▄▀▀   ▐     █   
--    █        ▄▀   █   █            █   
--  ▄▀▄▄▄▄▄▄▀ █   ▄▀     ▀▄▄▄▄▀    ▄▀    
--  █         ▐   ▐          ▐     █     
--  ▐                              ▐

-- bootstrap lazy.nvim
-- this block is yoinked from https://lazy.folke.io/installation 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "williamboman/mason.nvim",
      opts = { ensure_installed = { "prettier" } },
    },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      "nvim-treesitter/nvim-treesitter",
      version = false, -- last release is way too old and doesn't work on Windows
      build = ":TSUpdate",
      lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
      init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treesitter** module to be loaded in time.
        -- Luckily, the only things that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
      end,
      cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
      keys = {
        { "<c-space>", desc = "Increment Selection" },
        { "<bs>", desc = "Decrement Selection", mode = "x" },
      },
      opts_extend = { "ensure_installed" },
      ---@diagnostic disable-next-line: missing-fields
      opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "diff",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "luadoc", 
          "markdown",
          "markdown_inline", 
          "python", 
          "regex",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
       },
    },
      config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
        end
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
    {
      "windwp/nvim-ts-autotag",
      opts = {},
    },
    {
      "VidocqH/lsp-lens.nvim",
      opts = {}
    },
    {
      "askfiy/visual_studio_code",
      priority = 100,
      config = function()
        vim.cmd([[colorscheme visual_studio_code]])
      end,
    },
    {
      "amrbashir/nvim-docs-view",
      lazy = true,
      cmd = "DocsViewToggle",
      opts = {
        position = "right",
        width = 60
      }
    },
    {
      "ellisonleao/glow.nvim",
      config = true,
      cmd = "Glow"
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
      },
      config = function()
        local lspconfig = require("lspconfig")
        local mason = require("mason")

        mason.setup()

        lspconfig.denols.setup({})

        -- `npm i -g bash-language-server`
        lspconfig.bashls.setup({})
        lspconfig.gopls.setup({})

        lspconfig.css_variables.setup({})

        -- `npm i -g vscode-langservers-extracted`
        lspconfig.html.setup({})

        -- https://luals.github.io/#neovim-install
        --lspconfig.lua_ls.setup({})

        lspconfig.postgres_lsp.setup({})

        -- `npm install -g @tailwindcss/language-server`
        lspconfig.tailwindcss.setup({})

        -- `npm install -g typescript typescript-language-server`
        lspconfig.tsserver.setup({})
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      }
    }
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


-- ▄▀▄▄▄▄   ▄▀▀▄ ▄▀▄  ▄▀▀█▄▄   ▄▀▀▀▀▄ 
--█ █    ▌ █  █ ▀  █ █ ▄▀   █ █ █   ▐ 
--▐ █      ▐  █    █ ▐ █    █    ▀▄   
--  █        █    █    █    █ ▀▄   █  
-- ▄▀▄▄▄▄▀ ▄▀   ▄▀    ▄▀▄▄▄▄▀  █▀▀▀   
--█     ▐  █    █    █     ▐   ▐      
-- ▐        ▐    ▐    ▐                


-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ▄▀▀▄ █  ▄▀▀█▄▄▄▄  ▄▀▀▄ ▀▀▄      ▄▀▀▄ ▄▀▄  ▄▀▀█▄   ▄▀▀▄▀▀▀▄  ▄▀▀▀▀▄ 
--█  █ ▄▀ ▐  ▄▀   ▐ █   ▀▄ ▄▀     █  █ ▀  █ ▐ ▄▀ ▀▄ █   █   █ █ █   ▐ 
--▐  █▀▄    █▄▄▄▄▄  ▐     █       ▐  █    █   █▄▄▄█ ▐  █▀▀▀▀     ▀▄   
--  █   █   █    ▌        █         █    █   ▄▀   █    █      ▀▄   █  
--▄▀   █   ▄▀▄▄▄▄       ▄▀        ▄▀   ▄▀   █   ▄▀   ▄▀        █▀▀▀   
--█    ▐   █    ▐       █         █    █    ▐   ▐   █          ▐      
--▐        ▐            ▐         ▐    ▐            ▐                 

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})

-- check leader
vim.keymap.set('n', '<leader>t', ':echo "Hola, Mundo!"<CR>')

-- supposed to count but i cant get it to work 
require'lsp-lens'.setup({
  sections = {
    definition = function(count)
        return "defs: " .. count
    end,
    references = function(count)
        return "refs: " .. count
    end,
    implements = function(count)
        return "used: " .. count
    end,
    git_authors = function(latest_author, count)
        return "-" .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
    end,
  }
})

-- glow for md view
require('glow').setup({
  width_ratio = 1,
  height_ratio = 1,
  border = 'rounded'
})

-- https://patorjk.com/software/taag/#p=author&h=3&v=2&f=THIS&t=Hola
