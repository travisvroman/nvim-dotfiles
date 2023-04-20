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
