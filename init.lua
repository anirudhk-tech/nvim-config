-- =========================
-- Leader & Modes
-- =========================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.cracked = true
vim.g.training = false
if vim.env.TRAINING == "1" then
	vim.g.training = true
	vim.g.cracked = false
end

-- =========================
-- Core editor options
-- =========================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 200
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false

-- =========================
-- Bootstrap lazy.nvim
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- =========================
-- Plugins
-- =========================
require("lazy").setup({
	-- Entry screen
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local db = require("dashboard")
			local cracked_on = vim.g.cracked and vim.g.cracked ~= 0 and vim.g.cracked ~= ""
			local header = {
				"                                                                                  ",
				"                                                                                  ",
				"                      *((##*                                                      ",
				"                  /###%%#%&&&%,                           .%((//(/.               ",
				"                  #%%&&&&@@@@@@@*                        #%#&%@&%%##%%            ",
				"                 &&&@@@@@@@@@@@@@   .**(/(,*,/,*,       &@@@@@@@@@&&%%%*          ",
				"                 @@@@@@@@@@&@*                         %@@@@@@@@@@@@&&&&          ",
				"                  @@@@%/,               ,                 /@&%@@@@@@@&&&*         ",
				"                   &@,                 .                      /%@@@@@@@&.         ",
				"                .(..                  ,                         *#@@@@@#          ",
				"              .(                                                 .@@@@*           ",
				"              #                                                    (              ",
				"             ,             *%@%             .@@@@&*                 ,             ",
				"          *            /@@@@@@&            @@@@@@@@&                .*            ",
				"          ,            @@@@@@@@,   ...  .   .@@@@@@@@@                 /          ",
				"          /           @@@@@@/                  *&@@@@@&                           ",
				"         /           ,@&@@@.    %@@@@@@@@@,     .#@@@&&                 ,         ",
				"         #            (%%%/    *@@@@@@@@@%*      *&%#(*                 /         ",
				"         *        .     .           /                   , .,.                     ",
				"          .                /                     *                      *         ",
				"          *                #.    ./%,%/.      ,%                       /..        ",
				"          .,                                                        ,,*  *        ",
				"            %*                                 (%%#%%(,          *&*..    ,       ",
				"           ,/**#@%,**         ........ ...    #&&&@&&&%%%&(,#@@@@@&##%(%%#,,.     ",
				"          .%@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@(@@@@@@&&@@%&%%&&&#@@@@@@@@&&&%(,    ",
				"          (%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.@@@@@@@@@@@@@@@&&%&@%&@@@@@@@@@%#,   ",
				"        *&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/@@@@@@@@@@@@@@@@@@@@&%&&*&@@@@@@&&#.  ",
				"        &@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/@@@@@@@@@@@@@@@@@@@@@&@@@&&(@@@@@@&%* ",
				"      .#@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@%@@@(@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@##@@@@#.",
				"      /@@@@@@@@@@@%%&%@&##%&#%/(@(&#%%###%&%@/@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&/",
				"     @@@@@@@@@@%((/((**,.,,,,*,,.,*.*.,*,,,,.. @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/",
				"    .@@@@@@@@@/.*   .                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(",
				"                                                                                  ",
				"                                                                                  ",
				"                                                                                  ",
				"                                       NVIM                                       ",
				"                                                                                  ",
				"                                                                                  ",
			}

			local quotes = {
				-- Stoic
				"Waste no more time arguing about what a good man should be. Be one. -- Marcus Aurelius",
				"You have power over your mind, not outside events. Realize this, and you will find strength. -- Marcus Aurelius",
				"The impediment to action advances action. What stands in the way becomes the way. -- Marcus Aurelius",
				"Do not indulge in expectations. -- Marcus Aurelius",
				"If it is not right, do not do it; if it is not true, do not say it. -- Marcus Aurelius",
				"He who fears death will never do anything worthy of a living man. -- Seneca",
				"Luck is what happens when preparation meets opportunity. -- Seneca",
				"Begin at once to live, and count each separate day as a separate life. -- Seneca",
				"We suffer more in imagination than in reality. -- Seneca",
				"It is not that I am brave, it is that I am building myself. -- Seneca",
				"Man is not disturbed by events, but by the opinions he has of events. -- Epictetus",
				"Make the best use of what is in your power, and take the rest as it happens. -- Epictetus",
				"Seek not that the things which happen should happen as you wish; but wish the things which happen to be as they are, and you will have a tranquil flow of life. -- Epictetus",
				"First say to yourself what you would be; and then do what you have to do. -- Epictetus",
				"No man is free who is not master of himself. -- Epictetus",

				-- Greek
				"The unexamined life is not worth living. -- Socrates",
				"I know that I know nothing. -- Socrates",
				"He is richest who is content with the least. -- Socrates",
				"Strong minds discuss ideas, average minds discuss events, weak minds discuss people. -- Socrates",
				"The secret of change is to focus all your energy not on fighting the old, but on building the new. -- Socrates",
				"We are what we repeatedly do. Excellence, then, is not an act, but a habit. -- Aristotle",
				"It is the mark of an educated mind to be able to entertain a thought without accepting it. -- Aristotle",
				"Knowing yourself is the beginning of all wisdom. -- Aristotle",
				"Quality is not an act, it is a habit. -- Aristotle",
				"The whole is greater than the sum of its parts. -- Aristotle",
				"Do not go where the path may lead; go instead where there is no path and leave a trail. -- Plato",
				"Courage is knowing what not to fear. -- Plato",
				"Necessity is the mother of invention. -- Plato",
				"The price good men pay for indifference to public affairs is to be ruled by evil men. -- Plato",
				"Time is the moving image of eternity. -- Plato",
				"Everything flows, nothing stands still. -- Heraclitus",
				"Character is destiny. -- Heraclitus",
				"The soul is dyed the color of its thoughts. -- Heraclitus",

				-- Latin / Roman
				"Dum spiro, spero. (While I breathe, I hope.) -- Cicero",
				"If you have a garden and a library, you have everything you need. -- Cicero",
				"The foundation of justice is good faith. -- Cicero",
				"A room without books is like a body without a soul. -- Cicero",
				"Ars longa, vita brevis. (Art is long, life is short.) -- Hippocrates",
				"Per aspera ad astra. (Through hardship to the stars.) -- Seneca",
				"Nusquam est qui ubique est. (One who is everywhere is nowhere.) -- Seneca",

				-- Chinese (Confucian / Taoist / Sun Tzu)
				"The man who asks a question is a fool for a minute; the man who does not ask is a fool for life. -- Confucius",
				"It does not matter how slowly you go as long as you do not stop. -- Confucius",
				"The superior man is satisfied and composed; the mean man is always full of distress. -- Confucius",
				"Wheresoever you go, go with all your heart. -- Confucius",
				"Life is really simple, but we insist on making it complicated. -- Confucius",
				"Supreme excellence consists in breaking the enemy's resistance without fighting. -- Sun Tzu",
				"Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win. -- Sun Tzu",
				"In the midst of chaos, there is also opportunity. -- Sun Tzu",
				"Mastering others is strength. Mastering yourself is true power. -- Laozi",
				"A journey of a thousand miles begins with a single step. -- Laozi",
			}

			math.randomseed(os.time())
			local random_quote = quotes[math.random(#quotes)]

			table.insert(header, cracked_on and "[ CRACKED: ON ]" or "[ CRACKED: OFF ]")

			db.setup({
				theme = "doom",
				config = {
					header = header,
					center = {},
					footer = { " ", random_quote },
				},
			})
		end,
	},

	-- Theme
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({ style = "cool" })
			require("onedark").load()
		end,
	},

	-- Core Navigation & UI
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			filters = {
				dotfiles = false, -- Shows .env, .gitignore, etc.
				git_ignored = false, -- Shows files ignored by git
			},
			renderer = {
				highlight_git = true, -- Makes the "grayed out" effect work
			},
		},
	},
	{ "mg979/vim-visual-multi", branch = "master" },
	{ "windwp/nvim-autopairs", config = true },
	{ "MeanderingProgrammer/render-markdown.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" }, opts = {} },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					-- Web Development
					"typescript",
					"javascript",
					"html",
					"css",
					"json",
					"prisma",
					"graphql",

					-- Neovim & Config
					"lua",
					"vim",
					"vimdoc",
					"bash",
					"yaml",
					"toml",

					-- Backend & Systems
					"python",
					"rust",
					"go",
					"cpp",
					"c",
					"sql",
					"dockerfile",

					-- Documentation
					"markdown",
					"markdown_inline",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- LSP & Completion Core
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black", -- Python formatter
					"isort", -- Python import sorter
					"sql-formatter", -- SQL formatter
					"prettier", -- Web formatter
					"clang-format", -- C++ formatter
				},
			})
		end,
	},
	{ "williamboman/mason.nvim", config = true },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"kristijanhusak/vim-dadbod-completion",
		},
	},

	-- PYTHON ELITE
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = { name = { "venv", ".venv", "env" }, auto_refresh = true },
	},

	-- SQL ELITE
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod", lazy = true },
		cmd = { "DBUI", "DBUIToggle" },
	},

	-- WEB ELITE
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- GIT ELITE
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewClose" },
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup({
				default_mappings = true,
				disable_diagnostics = true,
			})
		end,
	},

	-- Auto-Formatter (Python, SQL, C++, Web)
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				python = { "isort", "black" },
				sql = { "sql_formatter" },
				cpp = { "clang-format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
			},
			format_on_save = { timeout_ms = 2500, lsp_fallback = true },
		},
	},
})

-- =========================
-- LSP & Completion Setup
-- =========================
local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "vim-dadbod-completion" },
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Updated for nvim-lspconfig v0.11+
require("mason-lspconfig").setup({
	ensure_installed = {
		"prismals", -- Prisma
		"lua_ls", -- Lua (Neovim config)
		"ts_ls", -- TypeScript/JS
		"pyright", -- Python
		"clangd", -- C/C++
		"sqls", -- SQL

		-- Web Dev & Styling
		"tailwindcss", -- Tailwind CSS
		"eslint", -- Linting for JS/TS
		"emmet_ls", -- HTML/CSS snippets
		"html", -- HTML
		"cssls", -- CSS
		"jsonls", -- JSON

		-- Backend & Systems
		"gopls", -- Go
		"rust_analyzer", -- Rust
		"bashls", -- Bash/Shell
		"dockerls", -- Docker
		"yamlls", -- YAML

		-- Documentation
		"marksman", -- Markdown
	},
})

-- Define the servers
local servers = { "clangd", "pyright", "sqls", "lua_ls", "ts_ls", "tailwindcss", "eslint", "emmet_ls" }

-- Modern way to enable LSPs without the deprecated 'require'
for _, server in ipairs(servers) do
	if vim.lsp.config[server] then
		vim.lsp.config[server].capabilities = capabilities
	end
end

vim.lsp.enable(servers)

-- =========================
-- Keymaps
-- =========================
local map = vim.keymap.set

-- Navigation & Tools
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File Explorer" })
map("n", "<leader>db", "<cmd>DBUIToggle<cr>", { desc = "SQL Explorer" })
map("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Python Venv Select" })

-- Git Diffview
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open Git Diff" })
map("n", "<leader>gx", "<cmd>DiffviewClose<cr>", { desc = "Close Git Diff" })

-- Helper: Copy/Paste/Select All
map("i", "<C-v>", "<C-r>+")
map({ "n", "v" }, "d", '"_d')
map("n", "<C-c>", "ggVG")
map("v", "<C-x>", '"+d')

map("n", "<leader>go", ":e <C-r>+<CR>", { desc = "Open file path from clipboard" })

-- LSP Global Bindings (Buffer Local)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "<leader>rn", vim.lsp.buf.rename, opts)
		map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		map("n", "<leader>dd", vim.diagnostic.open_float, opts)
		map("n", "[d", vim.diagnostic.goto_prev, opts)
		map("n", "]d", vim.diagnostic.goto_next, opts)
	end,
})
