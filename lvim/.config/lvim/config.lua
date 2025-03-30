-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.opt.guicursor = ''
vim.opt.relativenumber = true

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.hlsearch = false

lvim.plugins = {
    { 'AlexvZyl/nordic.nvim' },
    { 'olivercederborg/poimandres.nvim' },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        event = 'BufRead'
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup()
        end,
    },
    -- { 'github/copilot.vim' },
    {
        "supermaven-inc/supermaven-nvim",
        -- config = function()
        --     require("supermaven-nvim").setup({})
        -- end,
    },
    { "mrjones2014/nvim-ts-rainbow" },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
}

-- lvim.builtin.bufferline.active = false
lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.nvimtree.setup.git.timeout = 1000
lvim.builtin.nvimtree.setup.view.width = 40
lvim.builtin.cmp.formatting.duplicates.nvim_lsp = 1

vim.g.copilot_assume_mapped = true

lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 5000

lvim.colorscheme = "nordic"
-- lvim.builtin.treesitter.rainbow.enable = true

-- Keymaps
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape to Normal Mode' })
lvim.keys.normal_mode["<Leader>sg"] = ":Telescope live_grep<CR>"
lvim.keys.normal_mode["<Leader>x"] = ":NvimTreeCollapse<CR>"
lvim.keys.normal_mode["<C-f>"] = "<C-f>zz"
lvim.keys.normal_mode["<C-b>"] = "<C-b>zz"

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { name = "black" },
    {
        name = "prettier",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespace
        -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
        args = { "--print-width", "100" },
        ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
        -- filetypes = { "typescript", "typescriptreact" },
    },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    { name = "flake8" },
    {
        name = "shellcheck",
        args = { "--severity", "warning" },
    },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
    {
        name = "proselint",
    },
}

-- loading module to provide config for a server following steps from guide here
-- https://github.com/neovim/nvim-lspconfig/blob/ede4114e1fd41acb121c70a27e1b026ac68c42d6/doc/lspconfig.txt#L326
local configs = require 'lspconfig.configs'

-- copy paste from
-- https://github.com/neovim/nvim-lspconfig/blob/ede4114e1fd41acb121c70a27e1b026ac68c42d6/lua/lspconfig/server_configurations/gopls.lua
local util = require 'lspconfig.util'
local async = require 'lspconfig.async'
-- -> the following line fixes it - mod_cache initially set to value that you've got from `go env GOMODCACHE` command
local mod_cache = '/home/chizidotdev/go/pkg/mod'

-- setting the config for gopls, the contents below is also copy-paste from
-- https://github.com/neovim/nvim-lspconfig/blob/ede4114e1fd41acb121c70a27e1b026ac68c42d6/lua/lspconfig/server_configurations/gopls.lua
configs.gopls = {
    default_config = {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_dir = function(fname)
            -- see: https://github.com/neovim/nvim-lspconfig/issues/804
            if not mod_cache then
                local result = async.run_command 'go env GOMODCACHE'
                if result and result[1] then
                    mod_cache = vim.trim(result[1])
                end
            end
            if fname:sub(1, #mod_cache) == mod_cache then
                local clients = vim.lsp.get_active_clients { name = 'gopls' }
                if #clients > 0 then
                    return clients[#clients].config.root_dir
                end
            end
            return util.root_pattern 'go.work' (fname) or util.root_pattern('go.mod', '.git')(fname)
        end,
        single_file_support = true,
    },
    docs = {
        description = [[
  https://github.com/golang/tools/tree/master/gopls

  Google's lsp server for golang.
  ]],
        default_config = {
            root_dir = [[root_pattern("go.work", "go.mod", ".git")]],
        },
    },
}

-- Auto organize imports
local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local lsp_configs = require "lvim.lsp.manager"

lsp_configs.setup("tsserver", {
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        }
    }
})

-- increase null-ls timeout to 5000ms
lvim.builtin.which_key.mappings["l"]["f"] = {
    function()
        vim.lsp.format { timeout = 4000 }
    end,
    "LSP format",
}

-- Deno setup
local nvim_lsp = require('lspconfig')
nvim_lsp.denols.setup {
    -- on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

nvim_lsp.tsserver.setup {
    -- on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern("package.json"),
    single_file_support = false
}
