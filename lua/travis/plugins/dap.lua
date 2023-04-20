local dap = require("dap")


-- Some OS detection.
local os = "unknown"
if vim.loop.os_uname().sysname == "Darwin" then
    os = "osx"
elseif vim.loop.os_uname().sysname == "Linux" then
    os = "linux"
elseif vim.loop.os_uname().sysname == "Windows" then
    os = "windows"
else
    error("unknown OS/platform, config might not work");
end
-- NOTE: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)
if os == "linux" then
    dap.adapters.cppdbg = {
    	id = "cppdbg",
    	type = "executable",
    	command = "/home/travis/.config/nvim/plug_external/linux/extension/debugAdapters/bin/OpenDebugAD7",
}
elseif os == "osx" then
    dap.adapters.cppdbg = {
    	id = "cppdbg",
    	type = "executable",
    	command = "/home/travis/.config/nvim/plug_external/osx/extension/debugAdapters/bin/OpenDebugAD7",
    }
elseif os == "windows" then
    dap.adapters.cppdbg = {
	    id = "cppdbg",
        type = "executable",
	    command = "C:\\Users\\travis\\nvim\\plug_external\\win32\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe",
	    options = {
		    detached = false,
	    },
    }
else
    error("Unknown os, adapters not applied.");
end

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}

-- NOTE: If windows...
dap.configurations.c = {
	{
		name = "Launch Testbed",
		type = "cppdbg",
		request = "launch",
		program = function()
            local ext = ""
            if(os == "windows") then
            ext = ".exe"
            end

            return "${workspaceFolder}/bin/testbed" .. ext
        end,
        cwd = "${workspaceFolder}/bin",
		stopAtEntry = false,
        args = {},
		runInTerminal = false,
	},
    {
		name = "Launch",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/", "file")
		end,
		cwd = "${workspaceFolder}/bin",
		stopAtEntry = false,
        args = {},
		runInTerminal = false,
	},
	{
		name = "Attach to gdbserver :1234",
		type = "cppdbg",
		request = "launch",
		MIMode = "gdb",
		miDebuggerServerAddress = "localhost:1234",
		miDebuggerPath = "/usr/bin/gdb",
		cwd = "${workspaceFolder}/bin",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
	},
}

-- DAP UI setup
local dapui = require("dapui")
dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
                "watches",
                "stacks",
                "breakpoints",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

-- dap fires events, we can listen on them to open UI on certain events
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("mason-nvim-dap").setup({ automatic_setup = true })

-- NOTE: For some reason, only works with namespace of 0.
local namespace = 0 --vim.api.nvim_create_namespace("dap-hlng")
vim.api.nvim_set_hl(namespace, "red",   { fg = "#FF3939" })
vim.api.nvim_set_hl(namespace, "grey",   { fg = "#666666" })
vim.api.nvim_set_hl(namespace, "green",  { fg = "#9ece6a" })
vim.api.nvim_set_hl(namespace, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(namespace, "orange", { fg = "#f09000" })

vim.fn.sign_define('DapBreakpoint', { text='', texthl='red', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='orange', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='grey', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='green', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='yellow', linehl='DapStopped', numhl= 'DapStopped' })

--vim.fn.sign_define('DapBreakpoint',          { text='•', texthl='blue',   linehl='DapBreakpoint', numhl='DapBreakpoint' })
--vim.fn.sign_define('DapBreakpointCondition', { text='•', texthl='blue',   linehl='DapBreakpoint', numhl='DapBreakpoint' })
--vim.fn.sign_define('DapBreakpointRejected',  { text='•', texthl='orange', linehl='DapBreakpoint', numhl='DapBreakpoint' })
--vim.fn.sign_define('DapStopped',             { text='•', texthl='green',  linehl='DapBreakpoint', numhl='DapBreakpoint' })
--vim.fn.sign_define('DapLogPoint',            { text='•', texthl='yellow', linehl='DapBreakpoint', numhl='DapBreakpoint' })
