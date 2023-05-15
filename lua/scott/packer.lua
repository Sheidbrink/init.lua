vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- use 'shaunsingh/solarized.nvim'
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-context')
    use('nvim-treesitter/playground')

    use('theprimeagen/harpoon')
    --use('theprimeagen/refactoring')

    use('mbbill/undotree')

    --use('vim-airline/vim-airline')
    use('airblade/vim-gitgutter')
    use('tpope/vim-fugitive')
    --use('tpope/vim-surround')

    use({
        'neovim/nvim-lspconfig',
        requires = {
            -- LSP Support
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        }
    })
    -- Autocompletion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')

    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lua')
    use('saadparwaiz1/cmp_luasnip')

    -- Snippets
    use({
        'L3MON4D3/LuaSnip',
        requires = { 'rafamadriz/friendly-snippets' },
    })
    use('preservim/nerdcommenter')
end)
