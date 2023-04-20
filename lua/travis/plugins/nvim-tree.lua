local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
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

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

