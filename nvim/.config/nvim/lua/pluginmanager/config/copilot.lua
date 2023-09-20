vim.g.copilot_filetypes = {
    ["*"] = false,
    ["javascript"] = true,
    ["typescript"] = true,
    ["typescriptreact"] = true,
    ["lua"] = false,
    ["rust"] = true,
    ["c"] = true,
    ["c#"] = true,
    ["c++"] = true,
    ["go"] = true,
    ["python"] = true,
    ["markdown"] = true,
    ["sql"] = true,
}

require('keymaps').copilot()
