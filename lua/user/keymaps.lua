local nnoremap = require("user.keymap_utils").nnoremap
local vnoremap = require("user.keymap_utils").vnoremap
local inoremap = require("user.keymap_utils").inoremap
local tnoremap = require("user.keymap_utils").tnoremap
local xnoremap = require("user.keymap_utils").xnoremap
local utils = require("user.utils")

local M = {}

local TERM = os.getenv("TERM")

-- Normal --
-- Disable Space bar since it'll be used as the leader key
nnoremap("<space>", "<nop>")

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

-- Telescope
nnoremap("<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
nnoremap("<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch Open [B]uffers" })
nnoremap("<leader>sf", function()
	require("telescope.builtin").find_files({ hidden = true })
end, { desc = "[S]earch [F]iles" })
nnoremap("<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
nnoremap("<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })

nnoremap("<leader>sc", function()
	require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[S]earch [C]ommands" })

nnoremap("<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

