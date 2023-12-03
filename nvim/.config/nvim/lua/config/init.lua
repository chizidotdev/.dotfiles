local opt = vim.opt

require('keymaps').general()

opt.relativenumber = true
-- Make line numbers default
opt.number = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

-- Set highlight on search
opt.hlsearch = false

-- Set cursor type in insert mode to block
opt.guicursor = ''

-- Sync clipboard between OS and Neo
opt.clipboard = 'unnamedplus'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- set termguicolors to enable highlight groups
opt.termguicolors = true

-- Enable mouse mode
opt.mouse = 'a'

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Go syntax highlighting
vim.api.nvim_set_var('go_highlight_structs', 1)
vim.api.nvim_set_var('go_highlight_methods', 1)
vim.api.nvim_set_var('go_highlight_functions', 1)
vim.api.nvim_set_var('go_highlight_operators', 1)
vim.api.nvim_set_var('go_highlight_build_constraints', 1)
vim.api.nvim_set_var('go_highlight_extra_types', 1)
vim.api.nvim_set_var('go_highlight_fields', 1)
vim.api.nvim_set_var('go_highlight_types', 1)
vim.api.nvim_set_var('go_auto_sameids', 1)
