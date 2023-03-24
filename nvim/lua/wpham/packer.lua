-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end
-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])
--[[ os.execute("sdk use java 17.0.5-amzn") ]]
--[[ io.popen(string.format("sdk use java 17.0.5-amzn")) ]]
--[[ source "/home/wpham/.sdkman/bin/sdkman-init.sh" ]]
return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Color themes
	use("ray-x/aurora")
	use({ "bluz71/vim-nightfly-colors", as = "nightfly" })

	use("nvim-lua/plenary.nvim")
	use("nvim-tree/nvim-web-devicons")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/nvim-treesitter-context")

	-- Cmp
	use({ "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })
	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/mason.nvim" }) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" })

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Sidebar menu
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})
	-- using buffers
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- Shortcut keys
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	use("moll/vim-bbye")

	-- Trouble shooting
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Lsp
	use("mfussenegger/nvim-dap")
	use("mfussenegger/nvim-jdtls")
	use({ "tamton-aquib/zone.nvim" })
	use("feline-nvim/feline.nvim")
	use({
		"ray-x/navigator.lua",
		requires = {
			{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
			{ "neovim/nvim-lspconfig" },
		},
	})

	-- init.lua
	use("lukas-reineke/indent-blankline.nvim")

	-- Seach engine
	use({ "junegunn/fzf", run = "./install --bin" })
	use({
		"ibhagwan/fzf-lua",
		-- optional for icon support
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	-- Format markdown
	 use({ "junegunn/goyo.vim" })
	-- Lua
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Autoclosing tag
	use("AndrewRadev/tagalong.vim")
	use("tpope/vim-surround")

	-- Harpoon
	use("ThePrimeagen/harpoon")

	-- ChatGPT
	-- Packer
	use({
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({
				-- optional configuration
				keymaps = {
					submit = "<C-s>",
				},
			})
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	})

	-- Todo comments:
	-- TODO : You need to do this
	-- INFO : Some new information
	-- NOTE : Some note
	-- WARNING : This is a warning signal
	-- HACK : This is a hacking attempt, need to take a look
	-- BUG : Bro, you gotta fix this
	-- TEST : This need testing
	-- PASSED : Passed the test successfully
	-- FAILED : Failed miserably
	-- Lua
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				keywords = {
					FIX = {
						icon = " ", -- icon used for the sign, and in search results
						color = "error", -- can be a hex color, or a named color (see below)
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
						-- signs = false, -- configure signs for some keywords individually
					},
					INFO = { icon = " ", color = "#63a345" },
					TODO = { icon = " ", color = "#f1c232" },
					HACK = { icon = " ", color = "#e06666" },
					WARN = { icon = " ", color = "#e48929", alt = { "WARNING", "XXX" } },
					NOTE = { icon = " ", color = "hint" },
					TEST = { icon = "⏲ ", color = "test" },
					PASSED = { icon = " ", color = "#43c809" },
					FAILED = { icon = "", color = "#cc0000" },
				},
			})
		end,
	})
	use("windwp/nvim-ts-autotag")
	use("xiyaowong/link-visitor.nvim")
  use { 'codota/tabnine-nvim', run = "./dl_binaries.sh" }
  use 'simrat39/rust-tools.nvim'
end)
