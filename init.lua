m
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<Leader>b", "<cmd>NvimTreeOpen<CR>")
vim.keymap.set("n", "<Leader>k", "<cmd>bnext<CR>")
vim.keymap.set("n", "<Leader>d", "<cmd>bd<CR>")
vim.keymap.set("n", "<Leader>j", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<Leader>pp", "<cmd>Ex<CR>")

-- basics
vim.opt.title = true
vim.opt.number = true
vim.opt.encoding = "utf-8"
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- add your plugins here
		{
			"neovim/nvim-lspconfig",
			config = function() end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			branch = "master",
			lazy = false,
			build = ":TSUpdate",
			opts = {
				ensure_installed = {
					"bash",
					"python",
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
					"javascript",
					"typescript",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			},
		},
		{ "mason-org/mason.nvim", opts = {} },
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				ensure_installed = { "lua_ls", "eslint", "ast_grep", "tsserver", "jsonls", "cssls" },
				automatic_enable = true,
			},
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
		},
		{
			"EdenEast/nightfox.nvim",
			config = function()
				-- load the colorscheme
				vim.cmd([[colorscheme duskfox]])
				-- background transparent
				vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
			end,
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {},
		},
		{
			"akinsho/bufferline.nvim",
			version = "*",
			dependencies = "nvim-tree/nvim-web-devicons",
			opts = {},
		},
		{ "preservim/nerdtree" },
		{ "tiagofumo/vim-nerdtree-syntax-highlight" },
		{
			"nvim-tree/nvim-tree.lua",
			opts = {
				lazy = false,
			},
		},
		{
			"vimwiki/vimwiki",
			init = function()
				vim.g.vimwiki_list = { { path = "~/.config/vimwiki", path_html = "~/.config/vimwiki/html" } }
			end,
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
				},
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			},
		},
		{
			"saghen/blink.cmp",
			-- optional: provides snippets for the snippet source
			dependencies = { "rafamadriz/friendly-snippets" },

			-- use a release tag to download pre-built binaries
			version = "1.*",
			-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
			-- build = 'cargo build --release',
			-- If you use nix, you can build from source using latest nightly rust with:
			-- build = 'nix run .#build-plugin',

			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
				-- 'super-tab' for mappings similar to vscode (tab to accept)
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- All presets have the following mappings:
				-- C-space: Open menu or open docs if already open
				-- C-n/C-p or Up/Down: Select next/previous item
				-- C-e: Hide menu
				-- C-k: Toggle signature help (if signature.enabled = true)
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				keymap = { preset = "default" },

				appearance = {
					-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = "mono",
				},

				-- (Default) Only show the documentation popup when manually triggered
				completion = { documentation = { auto_show = false } },

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},

				-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
				-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
				-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
				--
				-- See the fuzzy documentation for more information
				fuzzy = { implementation = "prefer_rust_with_warning" },
			},
			opts_extend = { "sources.default" },
		},
		{ -- Fuzzy Finder (files, lsp, etc)
			"nvim-telescope/telescope.nvim",
			event = "VimEnter",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ -- If encountering errors, see telescope-fzf-native README for installation instructions
					"nvim-telescope/telescope-fzf-native.nvim",

					-- `build` is used to run some command when the plugin is installed/updated.
					-- This is only run then, not every time Neovim starts up.
					build = "make",

					-- `cond` is a condition used to determine whether this plugin should be
					-- installed and loaded.
					cond = function()
						return vim.fn.executable("make") == 1
					end,
				},
				{ "nvim-telescope/telescope-ui-select.nvim" },

				-- Useful for getting pretty icons, but requires a Nerd Font.
				{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			},
			config = function()
				-- Telescope is a fuzzy finder that comes with a lot of different things that
				-- it can fuzzy find! It's more than just a "file finder", it can search
				-- many different aspects of Neovim, your workspace, LSP, and more!
				--
				-- The easiest way to use Telescope, is to start by doing something like:
				--  :Telescope help_tags
				--
				-- After running this command, a window will open up and you're able to
				-- type in the prompt window. You'll see a list of `help_tags` options and
				-- a corresponding preview of the help.
				--
				-- Two important keymaps to use while in Telescope are:
				--  - Insert mode: <c-/>
				--  - Normal mode: ?
				--
				-- This opens a window that shows you all of the keymaps for the current
				-- Telescope picker. This is really useful to discover what Telescope can
				-- do as well as how to actually do it!

				-- [[ Configure Telescope ]]
				-- See `:help telescope` and `:help telescope.setup()`
				require("telescope").setup({
					-- You can put your default mappings / updates / etc. in here
					--  All the info you're looking for is in `:help telescope.setup()`
					--
					-- defaults = {
					--   mappings = {
					--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
					--   },
					-- },
					-- pickers = {}
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown(),
						},
					},
				})

				-- Enable Telescope extensions if they are installed
				pcall(require("telescope").load_extension, "fzf")
				pcall(require("telescope").load_extension, "ui-select")

				-- See `:help telescope.builtin`
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
				vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
				vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
				vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
				vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
				vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
				vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
				vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
				vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
				vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

				-- Slightly advanced example of overriding default behavior and theme
				vim.keymap.set("n", "<leader>/", function()
					-- You can pass additional configuration to Telescope to change the theme, layout, etc.
					builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end, { desc = "[/] Fuzzily search in current buffer" })

				-- It's also possible to pass additional configuration options.
				--  See `:help telescope.builtin.live_grep()` for information about particular keys
				vim.keymap.set("n", "<leader>s/", function()
					builtin.live_grep({
						grep_open_files = true,
						prompt_title = "Live Grep in Open Files",
					})
				end, { desc = "[S]earch [/] in Open Files" })

				-- Shortcut for searching your Neovim configuration files
				vim.keymap.set("n", "<leader>sn", function()
					builtin.find_files({ cwd = vim.fn.stdpath("config") })
				end, { desc = "[S]earch [N]eovim files" })
			end,
		},
	},
	-- automatically check for plugin updates
	checker = { enabled = true },
})
