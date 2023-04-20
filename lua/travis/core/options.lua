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
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus") -- use system clipboard to copy

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-") -- consider dash part of a word

vim.cmd("hi clear FIXME")
vim.cmd("hi clear TODO")
