
-- Protected call to set the colour scheme.
local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
    print("Colourscheme not found!")
    return
end
