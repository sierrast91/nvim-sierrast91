require("sierra-st.opts")
require("sierra-st.maps")
require("sierra-st.aucmd")

vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH
-- load plugins
require("lazy-config")
-- load theme
require("base46").load_all_highlights()
