vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps

-- do not add deletes to register
keymap.set("n", "<leader>d", '"_d')
keymap.set("v", "<leader>d", '"_d')

-- jump between buffers
keymap.set("n", "<C-,>", ":bprevious<CR>")
keymap.set("n", "<C-.>", ":bnext<CR>")

-- x key does not copy deleted character to register
keymap.set("n", "x", '"_x')

-- split screen commands
keymap.set("n", "<leader>sv", "<C-w>v") -- split vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- plugins

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

-- too many typos
vim.cmd(":command W w")
vim.cmd(":command WQ wq")
vim.cmd(":command Wq wq")
vim.cmd(":command Q q")
