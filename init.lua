vim.opt.guifont = { "MesloLGS NF", "h12" }

require("plugins-setup")

-- ----------------------------
-- Vim options
-- ----------------------------
local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
--[[ opt.background = "dark" ]]
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus") -- use system clipboard to copy

opt.splitright = true
opt.splitbelow = true

-- Global status line at bottom instead of one per window.
opt.laststatus = 3

--[[ opt.iskeyword:append("-") -- consider dash part of a word ]]

-- Disable default fixme and todo highlighting
vim.cmd("hi clear FIXME")
vim.cmd("hi clear TODO")

-- ----------------------------
-- Keymaps
-- ----------------------------

vim.g.mapleader = " " --leader key, default is \

-- Some OS detection.
local os = "unknown"
if vim.loop.os_uname().sysname == "Darwin" then
	os = "osx"
elseif vim.loop.os_uname().sysname == "Linux" then
	os = "linux"
elseif vim.loop.os_uname().sysname == "Windows_NT" then
	os = "windows"
else
	error("unknown OS/platform, config might not work")
end

local keymap = vim.keymap

-- Leave terminal mode by hitting esc.
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Leave Terminal mode (if in terminal)" })

-- general

keymap.set("n", "<A-Down>", ":move +1<cr>", { desc = "Move current line down" }) -- move line down
keymap.set("n", "<A-Up>", ":move -2<cr>", { desc = "Move current line up" }) -- move line up

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) --increment number
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) --decrement number

keymap.set("n", "<leader>ch", ":nohl<CR>", { desc = "[C]lear search [H]ighight" }) -- clear search highlight

keymap.set("n", "<leader>bx", ":bw<CR>", { desc = "[B]uffer [X]close (wipeout)" }) -- completely deletes current buffer (buffer wipeout)

keymap.set("n", "<leader>w", ":set wrap!<CR>", { desc = "Toggle Word [W]rap" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit [V]ertically" }) -- split vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit [H]orizontally" }) -- split horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make Split Windows [=]equal width" }) -- make split windows equal width.
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Current [S]plit [X]Close" }) -- close current split window.

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "[T]ab [N]ew" }) -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Current [T]ab [C]lose" }) -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Change [T]ab [N]ext" }) -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Change [T]ab [P]revious" }) -- go to previous tab
-- Source Vim configuration file and install plugins
-- keymap.set("n", "<leader>1", ":source ~/.config/nvim/init.lua | :Mason<CR>")
keymap.set("n", "<leader>1", ":ConfigReload<CR> <BAR> :Mason<CR>", { desc = "Reload config" })

-- Close/delete all buffers but this one
keymap.set("n", "<leader>xa", ":%bd|e#|bd#<CR>", { desc = "[X]Close [A]ll buffers but this one" })

-- Edit configuration file.
keymap.set("n", "<leader>2", ":e ~/.config/nvim/init.lua<CR>", { desc = "Edit nvim init.lua file" })

-- plugin keymaps

-- Comment
-- For some reason, needs "/" to be mapped as "_". This used to be Windows only, but it seems like
-- Linux and macOS require this in newer versions of neovim too.
keymap.set("n", "<c-_>", ':call feedkeys("gbc")<cr>', { desc = "Toggle Comment line/block (normal)" })
keymap.set("x", "<c-_>", "<Plug>(comment_toggle_blockwise_visual)<cr>", { desc = "Toggle Comment line/block (visual)" })

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle [E]xplorer tree" })

-- telescope
-- NOTE: Find more by using :Telescope builtin
keymap.set("n", "<leader>kb", "<cmd>Telescope keymaps<cr>", { desc = "View [K]ey [B]indings" })
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]ind [F]iles" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[F]ile [S]earch" }) -- find text throughout proj
keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "[F]ind [W]ord under cursor" }) -- find first string under cursor
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind in active [B]uffers" }) -- show active buffers
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "[F]ind [R]ecently opened files" })
keymap.set("n", "<leader>fn", "<cmd>Telescope help_tags<cr>")
keymap.set("n", "<leader>fwd", "<cmd>Telescope diagnostics<cr>", { desc = "[f]ind in [w]orkspace [d]iagnostics" })
keymap.set(
	"n",
	"<leader>fd",
	"<cmd>Telescope diagnostics bufnr=0<cr>",
	{ desc = "[f]ind in [d]iagnostics in current buffer" }
)
keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Search [D]ocument [S]ymbols" }) -- list document symbols.
keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Search [W]orkspace [S]ymbols" }) -- list workspace symbols.
keymap.set(
	"n",
	"<leader>dws",
	"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
	{ desc = "Search [D]ynamic [W]orkspace [S]ymbols" }
) -- dynamically lists for all workspace symbols.
keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", { desc = "[G]oto [R]eferences" }) -- List references
keymap.set(
	"n",
	"<leader>/",
	"<cmd>Telescope current_buffer_fuzzy_find<cr>",
	{ desc = "[/] Fuzzy find within current buffer" }
)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Show [G]it [C]ommits" })
keymap.set(
	"n",
	"<leader>gcb",
	"<cmd>Telescope git_bcommits<cr>",
	{ desc = "Show [G]it [C]ommits for current [B]uffer" }
)
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Show [G]it [B]ranches" })
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show [G]it [S]tatus" })

-- keybind options
--[[ local opts = { noremap = true, silent = true } ]]
keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", { desc = "[G]oto de[F]inition" }) -- show definition, references
keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "[G]oto [D]eclaration" }) -- go to declaration
keymap.set("n", "pd", "<cmd>Lspsaga peek_definition<CR>", { desc = "[P]eek [D]efinition" }) -- see definition and make edits in window
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "[G]oto [I]mplementation" }) -- go to implementation
keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "[C]ode [A]ction" }) -- see available code actions
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "[R]e[N]ame" }) -- smart rename
keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Show line [D]iagnostics" }) -- show  diagnostics for line
keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "Show cursor [d]iagnostics" }) -- show diagnostics for cursor
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Jump to preious [D]iagnostic" }) -- jump to previous diagnostic in buffer
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Jump to next [D]iagnostic" }) -- jump to next diagnostic in buffer
keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show documentation for what is under cursor" }) -- show documentation for what is under cursor
keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { desc = "Toggle [O]utline" }) -- see outline on right hand side

-- Build shortcuts
if os == "windows" then
	keymap.set("n", "<leader>bd", "<C-w>s<cr>|<cmd>:term build-debug.bat<cr>i", { desc = "[B]uild [D]ebug" })
	keymap.set("n", "<leader>br", "<C-w>s<cr>|<cmd>:term build-release.bat<cr>i", { desc = "[B]uild [R]elease" })
	keymap.set("n", "<leader>bc", "<C-w>s<cr>|<cmd>:term clean.bat<cr>i", { desc = "[B]uild->[C]lean" })
else
	keymap.set("n", "<leader>bd", "<C-w>s<cr>|<cmd>:term ./build-debug.sh<cr>i", { desc = "[B]uild [D]ebug" })
	keymap.set("n", "<leader>br", "<C-w>s<cr>|<cmd>:term ./build-release.sh<cr>i", { desc = "[B]uild [R]elease" })
	keymap.set("n", "<leader>bc", "<C-w>s<cr>|<cmd>:term ./clean.sh<cr>i", { desc = "[B]uild->[C]lean" })
end
--[[ -- DAP debugger
keymap.set("n", "<F5>", ":DapContinue<cr>")
keymap.set("n", "<F9>", ":DapToggleBreakpoint<cr>")
keymap.set("n", "<F10>", ":DapStepOver<cr>")
keymap.set("n", "<F11>", ":DapStepInto<cr>")
-- Shift + Fx = 12 + x, so F5 = F17, Ctrl + x = 24 + x, so F5 = F29
keymap.set("n", "<F23>", ":DapStepOut<cr>") -- shift + f11
keymap.set("n", "<F17>", ":DapTerminate<CR> <BAR> :DapUIClose<cr>")

-- Just in case the events fail, add the ability to toggle via keybind.
keymap.set("n", "<leader>dt", "<cmd>DapUIToggle<CR>")

-- Register some DapUI commands for convenience.
vim.api.nvim_create_user_command("DapUIOpen", "lua require'dapui'.open()", { nargs = 0 })
vim.api.nvim_create_user_command("DapUIClose", "lua require'dapui'.close()", { nargs = 0 })
vim.api.nvim_create_user_command("DapUIToggle", "lua require'dapui'.toggle()", { nargs = 0 }) ]]

-- Disable the F1 help key because it's annoyingly close to esc and keeps getting hit.
keymap.set("n", "<F1>", "<nop>")

keymap.set("", "<F1>", "<Esc>")
keymap.set("i", "<F1>", "<Esc>")

-- Map K to hover while session is active.
-- NOTE: Go to bottom of file after dap is loaded.

-- ----------------------------
-- Colourscheme
-- ----------------------------
local status, _ = pcall(vim.cmd, "colorscheme adwaita")
if not status then
	print("Colourscheme not found!")
	return
end

-- Disable the background colour.
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi LineNr guibg=NONE ctermbg=NONE")
vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
vim.cmd("hi WinBar guibg=NONE ctermbg=NONE")

-- ----------------------------
-- Comment
-- ----------------------------
local comment_setup, comment = pcall(require, "Comment")
if not comment_setup then
	return
end

comment.setup()

-- ----------------------------
-- nvim-tree
-- 
-- Provides a tree view file browser.
-- ----------------------------

local nvimtree_setup, nvimtree = pcall(require, "nvim-tree")
if not nvimtree_setup then
	return
end

-- recommended settings from nvim-tree docs
vim.g.loadednetrw = 1
vim.g.loaded_netrwPlugin = 1

-- change color of arrows in tree
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvimtree.setup({
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- closed folder icon
					arrow_open = "", -- open folder icon
				},
			},
		},
	},
	-- disable window_picker for explorer to work well with window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
	filters = {
		dotfiles = false,
	},
	git = {
		ignore = false, -- show .gitignored files.
	},
})

-- open nvim-tree on startup
local function open_nvim_tree(data)
	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not no_name and not directory then
		return
	end

	-- open the tree
	require("nvim-tree.api").tree.open()
end

-- NOTE: Enabling this will open the nvim tree on startup.
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- ----------------------------
-- lualine
--
-- Styles the status bar
-- ----------------------------

local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
	return
end

local lualine_nightfly = require("lualine.themes.nightfly")
local new_colors = {
	blue = "#65d1ff",
	green = "3effdc",
	violet = "#ff61ef",
	yellow = "#ffda7b",
	black = "#000000",
}

lualine_nightfly.normal.a.bg = new_colors.blue
lualine_nightfly.insert.a.bg = new_colors.green
lualine_nightfly.visual.a.bg = new_colors.violet
lualine_nightfly.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black,
	},
}

lualine.setup({
	options = {
		theme = lualine_nightfly,
		section_separators = "",
		component_separators = "",
	},
	sections = {
		lualine_c = {
			{
				"filename",
				path = 3,
			},
		},
	},
})

-- ----------------------------
-- telescope
--
-- Extensible fuzzy finder. Requires ripgrep to be installed on system to function.
-- ----------------------------

local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- Include hidden/dot files in search results.
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--no-ignore-vcs")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!{**/.git/*,**/*.c.o,**/*.c.d,**/node_modules/*,**/lib/*,**/webglpackage/*}")

telescope.setup({
	defaults = {
		hidden = true,
		vimgrep_arguments = vimgrep_arguments,
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			--[[ vimgrep_arguments = vimgrep_arguments, ]]
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = {
				"rg",
				"--files",
				"--hidden",
				"--no-ignore-vcs",
				"--glob",
				"!{**/.git/*,**/*.c.o,**/*.c.d,**/node_modules/*,**/lib/*,**/webglpackage/*}",
			},
		},
		live_grep = {
			-- Activates search for hidden files in live search
			additional_args = function(_ts)
				return { "--hidden" }
			end,
			--[[ file_ignore_patterns = { ".git/", "node_modules/", "webglpackage/" }, ]]
			--[[ glob_pattern = "!{**/.git/*,**/*.c.o,**/*.c.d,**/node_modules/*,**/lib/*,**/webglpackage/*}", ]]
		},
	},
})

telescope.load_extension("fzf")

-- ----------------------------
-- nvim-cmp
--
-- Provides code completion.
-- ----------------------------
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- ----------------------------
-- luasnip
--
-- Provides snippets.
-- ----------------------------
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- ----------------------------
-- lspkind
--
-- Visual enhancement of LSP completion items.
-- ----------------------------
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

vim.opt.completeopt = "menu,menuone" -- noselect

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- prev suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll docs
		["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll docs
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion suggestions
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- show completion suggestions
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, --snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
})

-- ----------------------------
-- Mason
--
-- Provides a repository and frontend that helps manage the installation of various third-party tools
-- (LSP servers, formatters, linters, etc...) that can be useful when running neovim
-- ----------------------------

local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- ----------------------------
-- Mason-LSP-Config
-- 
-- Uses Mason to ensure installation of user specified LSP servers and will tell 
-- nvim-lspconfig what command to use to launch those servers.
-- ----------------------------
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- ----------------------------
-- mason-tool-installer
--
-- a Neovim plugin that streamlines the installation and management of various external development tools used with Neovim. It acts as an installer for packages available through mason.nvim, which is a portable package manager for Neovim. Replaces null-ls.
-- ----------------------------
local mason_tool_installer_status, mason_tool_installer = pcall(require, "mason-tool-installer")
if not mason_tool_installer_status then
	return
end

mason.setup()

mason_lspconfig.setup({
	-- NOTE: Do not include clangd here, as it is handled in lspconfig below
	ensure_installed = {
		"html",
		"cssls",
		"lua_ls",
	},
})

mason_tool_installer.setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"eslint_d",
	},
})

-- ----------------------------
-- lspsaga
--
-- Provides additional functions like 'hover', diagnostics, code actions, etc.
-- ----------------------------
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return
end

saga.setup({
	scroll_preview = { scroll_down = "<C-k>", scroll_up = "<C-j>" },
	-- use enter to open a file with definition preview
	definition = {
		edit = "<CR>",
	},
	ui = {
		colors = {
			normal_bg = "#022746",
		},
	},
})

-- ----------------------------
-- lspconfig
--
-- Provides (very) basic configurations for LSP servers, and a simpler configuration to 
-- interact with neovim. One thing it does not, and cannot easily, provide is the path to the 
-- command to use when launching the server. That is handled by mason-lspconfig.
-- ----------------------------
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- ----------------------------
-- cmp_nvim_lsp
--
-- A source plugin for nvim-cmp, which is a powerful autocompletion framework for Neovim. Its primary function is to integrate Neovim's built-in Language Server Protocol (LSP) client with nvim-cmp, enabling nvim-cmp to display completion suggestions provided by language servers.
-- ----------------------------
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- enable keywords for available lsp server
local on_attach = function(client, bufnr)
	-- set keybinds

	-- typescript specific keymaps (e.g. rename file and update imports)
	--[[ if client.name == "ts_ls" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end ]]
end

-- used to enable auto completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

local clangd_capabilities = capabilities
clangd_capabilities.offsetEncoding = "utf-8"
lspconfig["clangd"].setup({
	capabilities = clangd_capabilities,
	on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			-- Make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- Make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- ----------------------------
-- conform
--
-- Allows additional formatter config/override capabilities. Also provides format on save.
-- ----------------------------
local conform_setup, conform = pcall(require, "conform")
if not conform_setup then
	return
end

local conform_formatters = {
	css = { "prettier" },
	html = { "prettier" },
	json = { "prettier" },
	yaml = { "prettier" },
	markdown = { "prettier" },
	lua = { "stylua" },
}

conform.setup({
	-- NOTE: Available formatters: https://github.com/stevearc/conform.nvim#formatters
	formatters_by_ft = conform_formatters,
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
})

-- ----------------------------
-- autopairs
-- ----------------------------
local autopairs_setup, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_setup then
	return
end

autopairs.setup({
	check_ts = true, -- enable it
	ts_config = {
		lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
		javascript = { "template_string" }, -- Don't add pairs in js template_string
		java = false,
	},
})

-- import nvim-autopairs completion functionality safely
local cmp_autopairs_setup, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_setup then
	return
end

-- import nvim-cmp plugin safely (completions plugin)
local cmp_setup, cmp_plugin = pcall(require, "cmp")
if not cmp_setup then
	return
end

-- make autopairs and completion work together
cmp_plugin.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- ----------------------------
-- treesitter
--
-- Provides advanced code parsing capabilities that significantly enhance the editing experience.
-- ----------------------------
local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status then
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"json",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"vim",
		"gitignore",
	},
	-- auto install above language parsers
	auto_install = true,
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {
			["]m"] = "@function.outer",
			["]]"] = "@class.outer",
		},
		goto_next_end = {
			["]M"] = "@function.outer",
			["]["] = "@class.outer",
		},
		goto_previous_start = {
			["[m"] = "@function.outer",
			["[["] = "@class.outer",
		},
		goto_previous_end = {
			["[M"] = "@function.outer",
			["[]"] = "@class.outer",
		},
	},
})

-- ----------------------------
-- gitsigns
-- ----------------------------

local gitsigns_setup, gitsigns = pcall(require, "gitsigns")
if not gitsigns_setup then
	return
end

gitsigns.setup()

-- ----------------------------
-- todo-comments
-- ----------------------------

-- import todo-comments plugin safely
local todocomments_status, todocomments = pcall(require, "todo-comments")
if not todocomments_status then
	return
end

-- TODO: This is a todo message.
-- HACK: This is a hack.
-- FIXME: This should really be fixed.
-- NOTE: This is just a note.
-- LEFTOFF: This is where I left off.

-- TODO(travis): This is a travis-specific todo.
--
-- nocheckin TODO: something else //nocheckin

local setup_config = {
	keywords = {
		TODO = { color = "#ff0000" },
		HACK = { color = "#ff6600" },
		NOTE = { color = "#008000" },
		FIXME = { color = "#f06292" },
		LEFTOFF = { color = "#ffff99" },
		NOCHECKIN = { color = "#ff00ff", alt = { "NOCHECKIN", "nocheckin" } },
	},
	highlight = {
		pattern = {
			[[(NOCHECKIN|nocheckin)\s*]],
			[[(KEYWORDS|keywords)\s*(\([^\)]*\))?:]],
		},
		keyword = "fg",
		comments_only = true,
	},
	merge_keywords = true,
}

todocomments.setup(setup_config)

-- Debug adapter
--[[ require("travis.dap_config") ]]

--[[ local dap = require("dap")
local api = vim.api
local keymap_restore = {}
dap.listeners.after["event_initialized"]["me"] = function()
	for _, buf in pairs(api.nvim_list_bufs()) do
		local keymaps = api.nvim_buf_get_keymap(buf, "n")
		for _, dap_keymap in pairs(keymaps) do
			if dap_keymap.lhs == "K" then
				table.insert(keymap_restore, dap_keymap)
				api.nvim_buf_del_keymap(buf, "n", "K")
			end
		end
	end
	api.nvim_set_keymap("n", "K", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after["event_terminated"]["me"] = function()
	for _, dap_keymap in pairs(keymap_restore) do
		api.nvim_buf_set_keymap(
			dap_keymap.buffer,
			dap_keymap.mode,
			dap_keymap.lhs,
			dap_keymap.rhs,
			{ silent = dap_keymap.silent == 1 }
		)
	end
	keymap_restore = {}
end
]]

-- Config reload functionality
local reload = function()
	for name, _ in pairs(package.loaded) do
		if name:match("^travis") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
end
vim.api.nvim_create_user_command("ConfigReload", reload, { nargs = 0 })

-- Remap some things because of my lazy shift finger, XD.
vim.api.nvim_create_user_command("Wa", ":wa", { nargs = 0 })
vim.api.nvim_create_user_command("Qa", ":qa", { nargs = 0 })
