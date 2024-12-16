local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("TextYankPost", {
	group = augroup("sy-hl-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("VimEnter", {
	group = augroup("EspIdfSetup", { clear = true }),
	pattern = "*",
	callback = function()
		local cwd = vim.fn.getcwd()
		if vim.fn.filereadable(cwd .. "/sdkconfig") and vim.fn.filereadable(cwd .. "/CMakeLists.txt") then
			local idf_path = "/Espressif/frameworks/esp-idf-v5.3-2"
			vim.fn.system("powershell -Command " .. idf_path .. "/export.bat")
			print("ESP-IDF enviorement configured")
		end
	end,
})
