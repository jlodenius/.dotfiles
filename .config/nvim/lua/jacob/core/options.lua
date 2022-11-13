local opt = vim.opt


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

-- clipboard
-- Uncomment to force vim to use system clipboard
-- opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- makes vim interpret hyphened words as one word
opt.iskeyword:append("-")

