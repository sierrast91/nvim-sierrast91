local g = vim.g
local o = vim.o

g.mapleader = ' '
g.maplocalleader = ' '

o.wrap = false
o.linebreak = true

vim.cmd("language en_US")

g.mapleader = " "
g.maplocalleader = " "
if vim.fn.has("win32")=true then
o.shell = "/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe"
end
o.showmode = false
o.laststatus = 3
o.signcolumn = 'yes'
o.cursorline = true
o.number = true
o.numberwidth = 5
o.scrolloff = 10
o.columns = 160

o.expandtab = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.smartindent = true

o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true

o.undofile = true
o.swapfile = false

o.splitbelow = true
o.splitright = true
