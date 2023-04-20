-- import todo-comments plugin safely
local status, todocomments = pcall(require, "todo-comments")
if not status then
	return
end

-- TODO: This is a todo message.
-- HACK: This is a hack.
-- FIXME: This should really be fixed.
-- NOTE: This is just a note.
-- LEFTOFF: This is where I left off.

-- TODO(travis): This is a travis-specific todo.

local setup_config = {
	keywords = {
		TODO = { color = "#ff0000" },
		HACK = { color = "#ff6600" },
		NOTE = { color = "#008000" },
		FIXME = { color = "#f06292" },
		LEFTOFF = { color = "#ffff99" },
	},
	highlight = {
		pattern = [[(KEYWORDS)\s*(\([^\)]*\))?:]],
		keyword = "fg",
	},
}

todocomments.setup(setup_config)
