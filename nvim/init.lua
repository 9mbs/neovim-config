-- ▄▀▀▀▀▄   ▄▀▀▄▀▀▀▄  ▄▀▀▀█▀▀▄  ▄▀▀█▀▄   ▄▀▀▀▀▄   ▄▀▀▄ ▀▄  ▄▀▀▀▀▄ 
--█      █ █   █   █ █    █  ▐ █   █  █ █      █ █  █ █ █ █ █   ▐ 
--█      █ ▐  █▀▀▀▀  ▐   █     ▐   █  ▐ █      █ ▐  █  ▀█    ▀▄   
--▀▄    ▄▀    █         █          █    ▀▄    ▄▀   █   █  ▀▄   █  
--  ▀▀▀▀    ▄▀        ▄▀        ▄▀▀▀▀▀▄   ▀▀▀▀   ▄▀   █    █▀▀▀   
--         █         █         █       █         █    ▐    ▐      
--         ▐         ▐         ▐       ▐         ▐                

-- line nums
vim.opt.number = true

-- relative line nums
vim.opt.relativenumber = true

-- disable netrw (if using Telescope)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- 24-bit color
vim.opt.termguicolors = true

-- space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--:nnoremap <leader>t :echo "Leader key works!"<CR>

-- check leader
vim.keymap.set('n', '<leader>t', ':echo "Hola, Mundo!"<CR>')


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
    -- add your plugins here
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- https://patorjk.com/software/taag/#p=author&h=3&v=2&f=THIS&t=Hola
