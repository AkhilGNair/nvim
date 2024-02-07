vim.g.mapleader = " "

-- Open Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Remove highlights
vim.keymap.set("n", "<leader>/", "<cmd>noh<CR>")

-- Make new splits
vim.keymap.set("n", "<C-A-Right>", "<cmd>vsplit<CR> <cmd>wincmd l<CR>")
vim.keymap.set("n", "<C-A-Down>", "<cmd>split<CR> <cmd>wincmd j<CR>")

-- Navigate splits
vim.keymap.set("n", "<C-Right>", "<cmd>wincmd l<CR>")
vim.keymap.set("n", "<C-Left>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-Up>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-Down>", "<cmd>wincmd j<CR>")

-- Terminal mode remaps
vim.keymap.set('n', '<leader>tt', '<cmd>terminal<CR>i')
vim.keymap.set('n', '<leader>tp', '<cmd>terminal<CR>iipython<CR>')
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

vim.api.nvim_exec([[
  augroup TerminalSettings
    autocmd!
    autocmd TermOpen * setlocal nonumber
    autocmd TermClose * setlocal number
 augroup END
]], false)

