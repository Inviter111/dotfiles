-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', 'jk', '<Esc>', { silent = true })

-- File browser
vim.keymap.set('n', '<leader>pv', function()
  local path = vim.b.netrw_curdir
  require('oil').open(path)
end, { desc = "Open file manager" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Better nav for omnicomplete
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Replaces selection with the contents of default buffer (deleted text placed in black hole register)
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Replace selection with default buffer" })

-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank selection to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- Delete to black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { silent = true, desc = "Delete to black hole register" })

vim.keymap.set("n", "Q", "<nop>")

-- Close current buffer
vim.keymap.set("n", "<leader>x", ":bd<CR>", { desc = "Close current buffer" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Copilot
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-K>', '<Plug>(copilot-accept-word)')

vim.keymap.set('n', '<leader>=', ':so ~/.config/nvim/init.lua<CR>', { desc = 'Reload configuration' })

-- Quickfix navigation
vim.keymap.set('n', '<leader>qj', ':cnext<CR>', { desc = 'Go to next quickfix item' })
vim.keymap.set('n', '<leader>qk', ':cprev<CR>', { desc = 'Go to previous quickfix item' })
vim.keymap.set('n', '<leader>qo', ':copen<CR>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>qc', ':cclose<CR>', { desc = 'Close quickfix list' })

vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'Open tmux sessionizer' })
