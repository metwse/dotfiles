vim.opt.nu = true
vim.opt.rnu = true

vim.opt.smartindent = true
vim.opt.wrap = false 

vim.opt.swapfile = false
vim.opt.backupdir = os.getenv('HOME') .. '/.vim/backupdir'
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.scrolloff = 8

vim.g.mapleader = ' '

vim.opt.fdm = 'marker'
vim.opt.colorcolumn = '80'
pcall(vim.cmd, { 'au BufWinLeave * mkview' })
pcall(vim.cmd, { 'au BufWinEnter * silent loadview' })
