local map = vim.keymap.set
-- insert mode actions
map("i", "jk", "<esc>", { desc = "easy escape" })
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
-- buffers
map("n", "<leader>x", "<cmd>confirm bd<cr>", { desc = "easy quit" })
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "next buffer" })
map("n", "<s-tab>", "<cmd>bprev<cr>", { desc = "previous buffer" })
-- windows
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
-- terminals
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map({ "n", "t" }, "<A-h>", function()
	require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, { desc = "terminal new horizontal term" })
map({ "n", "t" }, "<A-n>", function()
	require("nvchad.term").toggle({ pos = "sp", id = "ntoggleTerm" })
end, { desc = "terminal new horizontal term" })
-- nvim-tree
map("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", {})
map("n", "<c-n>", "<cmd>NvimTreeToggle<cr>", {})
-- telescope
map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "telescope: grep string" })
map("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "telescope: live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope: find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope: help page" })
map("n", "<leader>fx", "<cmd>Telescope marks<CR>", { desc = "telescope: find marks" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "telescope: find oldfiles" })

map("n", "<leader>fgc", "<cmd>Telescope git_commits<CR>", { desc = "telescope: git commits" })
map("n", "<leader>fgs", "<cmd>Telescope git_status<CR>", { desc = "telescope: git status" })

map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope: nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope: find files" })
map("n", "<leader>fgg", "<cmd>Telescope git_files<cr>", { desc = "telescope: find files" })
map(
	"n",
	"<leader>fn",
	"<cmd>Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "<cr>",
	{ desc = "telescope: find files" }
)

-- dap
map("n", "<leader>rr", "<cmd>lua require('dap').continue()<cr>", { desc = "DAP: run or continue" })
map("n", "<leader>rs", "<cmd>lua require('dap').close()<cr>", { desc = "DAP: stop" })
map("n", "<leader>rb", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "DAP: breakpoint" })
