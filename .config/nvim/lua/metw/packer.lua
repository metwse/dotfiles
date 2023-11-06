vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4-1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'sainnhe/sonokai',
        config = function()
            vim.cmd(':colorscheme sonokai\n') 
            vim.api.nvim_set_hl(0, 'Normal', {})
            vim.api.nvim_set_hl(0, 'EndOfBuffer', {})
        end
    }

    use 'theprimeagen/harpoon'
    use 'theprimeagen/vim-be-good'

    use 'mbbill/undotree'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }

    use 'lambdalisue/suda.vim'
    use 'tpope/vim-fugitive'


    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use { 'andweeb/presence.nvim',  { branch = 'xdg-runtime-dir-fix' } }

    use 'AckslD/nvim-neoclip.lua'
end)
