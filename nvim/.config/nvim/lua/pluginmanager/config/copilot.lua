vim.g.copilot_filetypes = {
    ["*"] = true,
    -- ["javascript"] = true,
    -- ["typescript"] = true,
    -- ["typescriptreact"] = true,
    -- ["lua"] = false,
    -- ["rust"] = true,
    -- ["c"] = true,
    -- ["c#"] = true,
    -- ["c++"] = true,
    -- ["go"] = true,
    -- ["python"] = true,
    -- ["markdown"] = true,
    -- ["sql"] = true,
    -- ["scss"]= true,
    -- ["css"]= true,
}

require('keymaps').copilot()
