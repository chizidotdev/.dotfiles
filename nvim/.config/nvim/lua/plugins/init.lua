-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	require("plugins.themes"),
	require("plugins.statusline"),
	require("plugins.whichkey"),
	require("plugins.gitsigns"),

	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gt", vim.cmd.Git)
		end,
	},

	require("plugins.telescope"),
	require("plugins.harpoon"),
	require("plugins.neotree"),
	require("plugins.noice"),

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	require("plugins.lspconfig"),
	require("plugins.cmp"),
	require("plugins.conform"),
	require("plugins.treesitter"),
	require("plugins.comment"),

	{ "m4xshen/autoclose.nvim", opts = {} },
	{ "windwp/nvim-ts-autotag", opts = {} },
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
})
