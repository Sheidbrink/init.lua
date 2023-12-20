vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "120"

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.ruler = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true

vim.opt.hidden = false
vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

--Make save updates and cmd timeouts happen faster
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 500
