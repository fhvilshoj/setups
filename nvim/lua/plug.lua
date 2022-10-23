-- [[ plug.lua ]]
-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
    function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        -- [[ Plugins ]]
        use {                                               -- filesystem navigation
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons'       -- filesystem icons
        }
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        }

        -- [[ Code Utils ]]
        use 'williamboman/nvim-lsp-installer'
        use 'neovim/nvim-lspconfig'

        -- [[ Code Completion ]]
        use 'dcampos/nvim-snippy'
        use 'dcampos/cmp-snippy'
        use 'honza/vim-snippets'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/cmp-emoji'
        use 'hrsh7th/nvim-cmp'

        use {
            "danymat/neogen",
            config = function()
                require('neogen').setup {}
            end,
            requires = "nvim-treesitter/nvim-treesitter",
        }

        -- [[ Search ]]
        use {
          'nvim-telescope/telescope.nvim', tag = '0.1.0',
          requires = { {'nvim-lua/plenary.nvim'} }
        }
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


        -- [[ Theme ]]
        use { 'mhinz/vim-startify' }                       -- start screen
        use {
            'nvim-lualine/lualine.nvim',                   -- statusline
            requires = {
                'kyazdani42/nvim-web-devicons',
                opt = true
            }
        }

        -- [[ Colors ]]
        use 'Mofiqul/dracula.nvim'
        use 'folke/lsp-colors.nvim'
    end
)

