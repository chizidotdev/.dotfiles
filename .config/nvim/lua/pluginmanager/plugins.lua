local plugins = {
    'EdenEast/nightfox.nvim',
    { 'olivercederborg/poimandres.nvim', opts = {} },
    'nvim-lua/plenary.nvim',
    { 'xiyaowong/transparent.nvim',      opts = {} },

    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = true,
                theme = 'nord',
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
            { 'j-hui/fidget.nvim', opts = {} },
            { 'folke/neodev.nvim', opts = {} }
        },
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
    'fatih/vim-go',
    'MunifTanjim/prettier.nvim',

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
    { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
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

    -- Testing
    { 'vim-test/vim-test',             opt = {} },

    { 'numToStr/Comment.nvim',         opts = {} },
    { 'folke/which-key.nvim',          opts = {} },
    'github/copilot.vim',
}

return plugins
