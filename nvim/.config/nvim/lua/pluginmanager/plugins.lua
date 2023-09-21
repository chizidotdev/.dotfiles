local plugins = {
    -- Themes
    'EdenEast/nightfox.nvim',
    'shaunsingh/nord.nvim',
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require 'nordic'.load()
        end
    },
    { 'olivercederborg/poimandres.nvim', opts = {} },
    'nvim-lua/plenary.nvim',
    { 'xiyaowong/transparent.nvim',      opts = {} },
    'navarasu/onedark.nvim',
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = true,
                component_separators = '|',
                section_separators = '',
            },
            extensions = { 'nerdtree', 'quickfix', 'lazy' }
        },
    },

    -- LspConfig
    'jose-elias-alvarez/null-ls.nvim',
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            { 'folke/neodev.nvim', opts = {} }
        },
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        requires = 'neovim/nvim-lspconfig',
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-refactor',
        },
        config = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    },
    { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
    'fatih/vim-go',
    'p00f/nvim-ts-rainbow',
    'MunifTanjim/prettier.nvim',
    'evanleck/vim-svelte',

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    -- File Navigation
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },

    -- Load luasnips + cmp related in insert mode only
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
            },
            -- autopairing of (){}[] etc
            { "windwp/nvim-autopairs", },
            -- cmp sources plugins
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },
    },
    'windwp/nvim-ts-autotag',

    -- Testing
    { 'vim-test/vim-test',                       opt = {} },

    { 'numToStr/Comment.nvim',                   opts = {} },
    { 'folke/which-key.nvim',                    opts = {} },
    'github/copilot.vim',
}

return plugins
