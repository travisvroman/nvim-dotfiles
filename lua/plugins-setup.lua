local M = {}

M.__HAS_NVIM_08 = vim.fn.has("nvim-0.8") == 1
M.__HAS_NVIM_010 = vim.fn.has("nvim-0.10") == 1
M.IS_WINDOWS = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- lib functions used by plugins
	use("nvim-lua/plenary.nvim")

	-- Colourscheme, updated from original.
	use("travisvroman/adwaita.nvim")

	use("christoomey/vim-tmux-navigator") -- tmux and split window navigation
	use("szw/vim-maximizer") -- maximizes and restores current window.

	use("tpope/vim-surround")
	use("vim-scripts/ReplaceWithRegister")

	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- icons
	use("nvim-tree/nvim-web-devicons")

	-- status bar/line
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding
	-- NOTE: This works differently on Windows and requires cmake.
	if vim.fn.has("win32") == 1 then
		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		})
	else
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	end

	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

	-- autocomplete
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- managing and installing LSP servers, linters and formatters.
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("WhoIsSethDaniel/mason-tool-installer.nvim")

	-- configure servers
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	use("onsails/lspkind.nvim")

	-- formatting and linting
	use("stevearc/conform.nvim")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	use("lewis6991/gitsigns.nvim")

	-- Custom comment highlights
	use("travisvroman/todo-comments.nvim")

	use("mfussenegger/nvim-dap") -- visual debugger
	use("jay-babu/mason-nvim-dap.nvim")

	use("rcarriga/nvim-dap-ui") -- debugger ui

	if packer_bootstrap then
		require("packer").sync()
	end
end)
