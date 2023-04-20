vim.opt.guifont = { "MesloLGS NF", "h12" }

-- NOTE: replace 'travis' with your own name, and rename that folder as well.
require("travis.plugins-setup")
require("travis.core.options")
require("travis.core.keymaps")
require("travis.core.colorscheme")
require("travis.plugins.comment")
require("travis.plugins.nvim-tree")
require("travis.plugins.lualine")
require("travis.plugins.telescope")
require("travis.plugins.nvim-cmp")
require("travis.plugins.lsp.mason")
require("travis.plugins.lsp.lspsaga")
require("travis.plugins.lsp.lspconfig")
require("travis.plugins.lsp.null-ls")
require("travis.plugins.autopairs")
require("travis.plugins.treesitter")
require("travis.plugins.gitsigns")
require("travis.plugins.todo-comments")
require("travis.plugins.dap")

local reload = require("travis.core.reload")
vim.api.nvim_create_user_command("ConfigReload", reload, { nargs = 0 })
