local keymap = vim.keymap
local map = vim.api.nvim_set_keymap
local opts = { noremap = false }

vim.g.mapleader = " "

keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

keymap.set("n", "<leader>w", ":w<CR>", opts)
keymap.set("n", "<leader>q", ":q<CR>", opts)
keymap.set("n", "<leader>x", ":q!<CR>", opts)

keymap.set("n", "<leader>b", "<C-o>", { desc = "Go back to previous location" })

map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

map('n', '<leader>g', ':Fugit2<CR>', opts)

-- Harpoon keymaps
vim.keymap.set("n", "<leader>ha", function()
    require("harpoon.mark").add_file()
end, { desc = "Harpoon: Add file" })

vim.keymap.set("n", "<leader>hh", function()
    require("harpoon.ui").toggle_quick_menu()
end, { desc = "Harpoon: Toggle quick menu" })

