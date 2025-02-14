vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>nn', ':Ex\n')
vim.keymap.set('n', '<leader>nh', ':Lex\n')
vim.keymap.set('n', '<leader>nj', ':Hex\n')
vim.keymap.set('n', '<leader>nk', ':Sex\n')
vim.keymap.set('n', '<leader>nl', ':Vex\n')
vim.keymap.set('n', '<leader>nt', ':Tex\n')

vim.keymap.set('n', '<leader>H', '<C-w>h')
vim.keymap.set('n', '<leader>J', '<C-w>j')
vim.keymap.set('n', '<leader>K', '<C-w>k')
vim.keymap.set('n', '<leader>L', '<C-w>l')

vim.cmd(':ca Q q')
vim.cmd(':ca W w')
vim.cmd(':ca WQ wq')
vim.cmd(':ca Wq wq')
vim.cmd(':ca wQ wq')
vim.cmd(':ca X x')



local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', function() builtin.grep_string({ search = vim.fn.input('Grep > ')}) end, {})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fu', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fy', builtin.registers, {})
vim.keymap.set('n', '<leader>fa', builtin.builtin, {})




local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<leader>e', ui.toggle_quick_menu)

vim.keymap.set('n', '<leader>j', function() ui.nav_file(1) end)
vim.keymap.set('n', '<leader>k', function() ui.nav_file(2) end)
vim.keymap.set('n', '<leader>l', function() ui.nav_file(3) end)
vim.keymap.set('n', '<leader>:', function() ui.nav_file(4) end)
vim.keymap.set('n', '<leader>u', function() ui.nav_file(5) end)
vim.keymap.set('n', '<leader>i', function() ui.nav_file(6) end)
vim.keymap.set('n', '<leader>o', function() ui.nav_file(7) end)
vim.keymap.set('n', '<leader>p', function() ui.nav_file(8) end)



vim.keymap.set('n', '<leader>u', ':UndotreeToggle\n')



local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.setup()



vim.keymap.set('n', '<leader>g', ':Git\n')



for c in ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789'):gmatch('.') do
    vim.keymap.set('n', '<leader>y' .. c, ':Telescope neoclip ' .. c .. '\n')
end
vim.keymap.set('n', '<leader><leader>y', ':Telescope neoclip unnamed\n')
vim.keymap.set('n', '<leader>y*', ':Telescope neoclip star\n')
vim.keymap.set('n', '<leader>y+', ':Telescope neoclip plus\n')
