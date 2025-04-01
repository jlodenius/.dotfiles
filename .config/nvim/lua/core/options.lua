local opt = vim.opt

-- transparent_background
vim.g.transparent_background = true

-- line number
opt.relativenumber = true
opt.number = true

-- tabs & indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- x padding when jumping
opt.sidescrolloff = 15

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace key
opt.backspace = "indent,eol,start"

-- split windows
opt.splitright = true
opt.splitbelow = true

-- dont highlight search
opt.hlsearch = false

-- cursor settings
vim.cmd("set guicursor=n:blinkon100,n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20")

-- swap file settings
opt.swapfile = true -- Keep swapfiles for recovery
opt.directory = vim.fn.expand("~/.local/share/nvim/swap//") -- Where to store swapfiles
opt.updatetime = 300 -- Faster swap file writing
opt.backup = false -- Don't keep backup files
opt.writebackup = false -- Don't write backup files

-- persist undo history
opt.undofile = true

-- for avante
opt.laststatus = 3
