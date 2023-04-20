require('metw.packer')
require('metw.set')
require('metw.remap')

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'javascript', 'css', 'sql', 'html', 'c', 'lua', 'vim', 'help' },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
}
