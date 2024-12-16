local map = vim.keymap.set
local opts = function(desc)
	return { desc = desc, noremap = true, silent = true }
end
-- insert related
map("i", "jk", "<esc>", opts("easy escape"))
map("i", "<C-b>", "<ESC>^i", opts("move beginning of line"))
map("i", "<C-e>", "<End>", opts("move end of line"))
map("i", "<C-h>", "<Left>", opts("move left"))
map("i", "<C-l>", "<Right>", opts("move right"))
map("i", "<C-j>", "<Down>", opts("move down"))
map("i", "<C-k>", "<Up>", opts("move up"))

-- register related
map({ "n", "v" }, "gy", '"+y', opts("global yank"))
map({ "n", "v" }, "gp", '"+p', opts("global paste"))

map("v", "gP", '"_dP', opts("persistant paste"))

-- move blocks
map({ "v" }, "<a-k>", ":m '<-2<cr>gv=gvzz", opts("move block up"))
map({ "v" }, "<a-j>", ":m '>+1<cr>gv=gvzz", opts("move block down"))

map({ "n" }, "<a-k>", ":m .-2<cr>==zz", opts("move block up"))
map({ "n" }, "<a-j>", ":m .+1<cr>==zz", opts("move block down"))

-- buffers
map("n", "<leader>x", "<cmd>confirm bd<cr><cmd>bnext<cr>", opts("easy quit"))
map("n", "<tab>", "<cmd>bnext<cr>", opts("next buffer"))
map("n", "<s-tab>", "<cmd>bprev<cr>", opts("previous buffer"))

-- windows
map("n", "<C-h>", "<C-w>h", opts("switch window left"))
map("n", "<C-l>", "<C-w>l", opts("switch window right"))
map("n", "<C-j>", "<C-w>j", opts("switch window down"))
map("n", "<C-k>", "<C-w>k", opts("switch window up"))
--[[
-- terminals ]]
map("t", "<C-x>", "<C-\\><C-N>", opts("terminal escape terminal mode"))
map({ "n", "t" }, "<A-h>", function()
	require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, opts("terminal new horizontal term"))
map({ "n", "t" }, "<A-n>", function()
	require("nvchad.term").toggle({ pos = "sp", id = "ntoggleTerm" })
end, opts("terminal new horizontal term"))
-- nvim-tree
map("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", {})

-- telescope
map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", opts("telescope: grep string"))
map("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", opts("telescope: live grep"))
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts("telescope: find buffers"))
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts("telescope: help page"))
map("n", "<leader>fx", "<cmd>Telescope marks<CR>", opts("telescope: find marks"))
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", opts("telescope: find oldfiles"))

map("n", "<leader>fgc", "<cmd>Telescope git_commits<CR>", opts("telescope: git commits"))
map("n", "<leader>fgs", "<cmd>Telescope git_status<CR>", opts("telescope: git status"))

map("n", "<leader>th", "<cmd>Telescope themes<CR>", opts("telescope: nvchad themes"))
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts("telescope: find files"))
map("n", "<leader>fgg", "<cmd>Telescope git_files<cr>", opts("telescope: find files"))
map(
	"n",
	"<leader>fn",
	"<cmd>Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "<cr>",
	opts("telescope: find files")
)

-- dap
map("n", "<leader>rr", "<cmd>lua require('dap').continue()<cr>", opts("DAP: run or continue"))
map("n", "<leader>rs", "<cmd>lua require('dap').close()<cr>", opts("DAP: close"))
map("n", "<leader>rp", "<cmd>lua require('dap').pause()<cr>", opts("DAP: pause"))
map("n", "<leader>rb", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts("DAP: breakpoint"))
