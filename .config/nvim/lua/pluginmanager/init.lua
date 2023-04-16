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

local plugins = require 'pluginmanager.plugins'
require('lazy').setup(plugins)

require 'pluginmanager.config.lualine'

require 'pluginmanager.config.nvimtree'
require 'pluginmanager.config.telescope'

require 'pluginmanager.config.lspconfig'
require 'pluginmanager.config.treesitter'
require 'pluginmanager.config.cmp'
require 'pluginmanager.config.luasnip'
require 'pluginmanager.config.prettier'
require 'pluginmanager.config.copilot'
