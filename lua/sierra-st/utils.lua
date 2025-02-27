local M = {}

M.find_elf = function()
	local cwd = vim.fn.getcwd()
	local delim = vim.fn.has("win32") and "\\" or "/"
	local build = cwd .. delim .. "build"
	local file = nil
	if not vim.fn.isdirectory(build) == "0" then
		return vim.fn.input("path to exe: ", cwd .. delim, "file")
	end
	for _, name in ipairs(vim.fn.readdir(build)) do
		if name:match("%.elf$") then
			file = build .. delim .. name
		end
	end
	return file
end

return M
