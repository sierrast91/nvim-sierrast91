local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("TextYankPost", {
	group = augroup("sy-hl-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
