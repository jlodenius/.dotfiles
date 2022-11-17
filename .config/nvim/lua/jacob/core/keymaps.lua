vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps

-- jump between buffers
keymap.set("n", "<C-,>", ":bprevious<cr>")
keymap.set("n", "<C-.>", ":bnext<cr>")

-- x key does not copy deleted character to register
keymap.set("n", "x", '"_x"')

-- split screen commands
keymap.set("n", "<leader>sv", "<C-w>v") -- split vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- plugins

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<cr>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
