-- [[ keys.lua ]]
local map = vim.api.nvim_set_keymap

--remap the key used to leave insert mode 
map('i', 'jj', '', {})

-- Toggle nvim-tree
map('n', '<leader>n', [[:NvimTreeToggle<Cr>]], {})
map('n', '<leader>m', [[:NvimTreeFocus<Cr>]], {})

