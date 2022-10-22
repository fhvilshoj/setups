--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"


-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- IMPORTS
require('vars')      -- Variables
require('opts')      -- Options
require('keys')      -- Keymaps
require('plug')      -- Plugins

-- PLUGINS: Add this section
-- require('plugins')

require('nvim-tree').setup{}
require('lualine').setup {
  options = {
    theme = 'dracula-nvim'
  }
}

require("nvim-lsp-installer").setup {
    automatic_installation = true -- automatically detect which servers to install (based on which servers are set up via lspconfig)
}

-- require'lspconfig'.pyright.setup{}
require('cmp_configuration')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').pyright.setup{
    capabilities = capabilities
}

require('snippy').setup({
    mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
        nx = {
            ['<leader>x'] = 'cut_text',
        },
    },
})

require('neogen').setup({ 
    snippet_engine = "snippy",
    languages = {
        lua = {
            template = { annotation_convention = "emmylua" }
        },
        python = {
            template = { annotation_convention = "google_docstrings" }
        }
    }
})

