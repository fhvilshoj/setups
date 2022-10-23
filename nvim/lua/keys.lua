-- [[ keys.lua ]]
local map = vim.api.nvim_set_keymap

--remap the key used to leave insert mode 
map('i', 'jj', '', {})

-- Toggle nvim-tree
map('n', '<leader>n', [[:NvimTreeToggle<Cr>]], {})
map('n', '<leader>m', [[:NvimTreeFocus<Cr>]], {})

-- Fuzzy find
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fd', builtin.lsp_dynamic_workspace_symbols, {})

