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
vim.opt.hlsearch = false

-- cursor settings
vim.cmd("set guicursor=n:blinkon100,n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20")
