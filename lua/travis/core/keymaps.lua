vim.g.mapleader = " " --leader key, default is \

local keymap = vim.keymap

-- general
keymap.set("n", "<leader>+", "<C-a>") --increment number
keymap.set("n", "<leader>-", "<C-x>") --decrement number

keymap.set("n", "<leader>nh", ":nohl<CR>") -- clear search highlight

keymap.set("n", "<leader>bx", ":bw<CR>") -- completely deletes current buffer (buffer wipeout)

keymap.set("n", "<leader>sv", "<C-w>v") -- split vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width.
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window.

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab
-- Source Vim configuration file and install plugins
-- keymap.set("n", "<leader>1", ":source ~/.config/nvim/init.lua | :Mason<CR>")
keymap.set("n", "<leader>1", ":ConfigReload<CR> <BAR> :Mason<CR>")

-- Edit configuration file.
keymap.set("n", "<leader>2", ":e ~/.config/nvim/init.lua<CR>")

-- plugin keymaps

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find text throughout proj
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find first string under cursor
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- show active buffers
keymap.set("n", "<leader>fn", "<cmd>Telescope help_tags<cr>")
keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>") -- list document symbols.
keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>") -- list workspace symbols.
keymap.set("n", "<leader>dws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>") -- dynamically lists for all workspace symbols.

-- DAP debugger
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
vim.api.nvim_create_user_command("DapUIToggle", "lua require'dapui'.toggle()", { nargs = 0 })
