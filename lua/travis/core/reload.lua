-- Reload all user config lua modules
return function()
	for name, _ in pairs(package.loaded) do
		-- NOTE: change name here to your own.
		if name:match("^travis") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
end
