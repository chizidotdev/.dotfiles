require('lspconfig')
local set = vim.keymap.set

-- require('lspconfig').gopls.setup({
--     on_attach = on_attach,
-- })

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
