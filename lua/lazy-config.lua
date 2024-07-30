local lazy_config = {
	change_detection = { notify = false },
	install = { colorscheme = { "nvchad", "slate" } },
	ui = {
		size = { width = 0.6, height = 0.6 },
		border = "single",
		title = " Lazy Package Manager ",
	},
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({ { import = "sierra-st.plugins" } }, lazy_config)
