local set = vim.keymap.set

local C = {}

-------------------------- [[ General ]] --------------------------
C.general = function()
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

    -- Remap for dealing with word wrap
    set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Explorer' })

    set('n', '<C-f>', '<C-f>zz')
    set('n', '<C-b>', '<C-b>zz')

    set('i', 'jk', '<Esc>', { desc = 'Escape to Normal Mode' })
    set('n', '<C-h>', '<C-w>h', { desc = 'Move to left buffer' })
    set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom buffer' })
    set('n', '<C-k>', '<C-w>k', { desc = 'Move to top buffer' })
    set('n', '<C-l>', '<C-w>l', { desc = 'Move to right buffer' })

    -- navigate within insert mode
    set('i', '<C-h>', '<Left>')
    set('i', '<C-l>', '<Right>')
    set('i', '<C-j>', '<Down>')
    set('i', '<C-k>', '<Up>')

    -- set('n', '<C-c>', '<cmd> %y+ <CR>', { desc = 'Copy entire file to clipboard' })
end

------------------------- [[ NvimTree ]] --------------------------
C.nvimtree = function()
    set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'NvimTree toggle' })
    set('n', '<leader>t', ':NvimTreeFocus<CR>', { desc = 'NvimTree focus' })
end

-------------------------- [[ Telescope ]] --------------------------
C.telescope = function()
    -- See `:help telescope.builtin`
    set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, { desc = '[/] Fuzzily search in current buffer' })

    set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
end

-------------------------- [[ Gitsigns ]] --------------------------
C.gitsigns = function()
    set('n', '<leader>gb', require('gitsigns').blame_line, { desc = '[G]it [B]lame line' })
end

-------------------------- [[ Prettier Format ]] --------------------------
C.prettier = function()
    set({'n', 'v'}, '<leader>pf', require('prettier').format, { desc = '[G]it [B]lame line' })
end

-------------------------- [[ Copilot ]] --------------------------
C.copilot = function()
    local opts = { silent = true, expr = true }
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true

    -- set("i", "<Tab>", 'copilot#Accept("<CR>")', opts)
    set("i", "<C-J>", 'copilot#Accept("<CR>")', opts)
    -- set("i", "<C-H>", 'copilot#Previous()', opts)
    -- set("i", "<C-K>", 'copilot#Next()', opts)
    -- vim.api.nvim_set_keymap("i", "<C-Tab>", 'copilot#Accept("<CR>")')
end

return C
