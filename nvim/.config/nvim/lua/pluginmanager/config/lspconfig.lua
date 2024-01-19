require('lspconfig')
local set = vim.keymap.set
local util = require('lspconfig.util')
local async = require('lspconfig.async')
local mod_cache = '/home/chizidotdev/go/pkg/mod'

require('lspconfig.configs').gopls = {
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
        return util.root_pattern 'go.work'(fname) or util.root_pattern('go.mod', '.git')(fname)
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
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
set('n', '<leader>e', vim.diagnostic.open_float)
set('n', '[d', vim.diagnostic.goto_prev)
set('n', ']d', vim.diagnostic.goto_next)
set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        set('n', 'gD', vim.lsp.buf.declaration, opts)
        set('n', 'gd', vim.lsp.buf.definition, opts)
        set('n', 'K', vim.lsp.buf.hover, opts)
        set('n', 'gi', vim.lsp.buf.implementation, opts)
        set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        set('n', 'gr', vim.lsp.buf.references, opts)
        set({'n', 'v'}, '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

require("mason").setup {
    registries = {
        "github:mason-org/mason-registry@2023-05-15-next-towel"
    }
}
require("mason-lspconfig").setup() 

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name)  -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
}
