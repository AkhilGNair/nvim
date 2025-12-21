local nnoremap = require("user.keymap_utils").nnoremap
local vnoremap = require("user.keymap_utils").vnoremap
local inoremap = require("user.keymap_utils").inoremap
local tnoremap = require("user.keymap_utils").tnoremap
local xnoremap = require("user.keymap_utils").xnoremap

local M = {}

local TERM = os.getenv("TERM")

-- Normal --
-- Disable Space bar since it'll be used as the leader key
nnoremap("<space>", "<nop>")

-- Debug keypresses
vim.keymap.set("n", "<leader>kk", function()
  local key = vim.fn.getcharstr()
  print(vim.fn.keytrans(key))
end, { desc = "Show next key pressed" })

-- Open Explorer
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>")

-- Remove highlights
vim.keymap.set("n", "<leader>rh", "<cmd>noh<CR>", { desc = "[r]emove [h]ighlights" })

-- Using splits
-- vim.keymap.set("n", "<C-A-Right>", "<cmd>vsplit<CR> <cmd>wincmd l<CR>")
-- vim.keymap.set("n", "<C-A-Down>", "<cmd>split<CR> <cmd>wincmd j<CR>")
-- vim.keymap.set("n", "<C-Right>", "<cmd>wincmd l<CR>")
-- vim.keymap.set("n", "<C-Left>", "<cmd>wincmd h<CR>")
-- vim.keymap.set("n", "<C-Up>", "<cmd>wincmd k<CR>")
-- vim.keymap.set("n", "<C-Down>", "<cmd>wincmd j<CR>")

-- splits
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>wh", "<cmd>split<CR>", { desc = "Split horizontal" })

-- navigation
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Window prefix" })
-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Using tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabedit %<CR>")
vim.keymap.set("n", "<leader>tc", "<cmd>tabc<CR>")
vim.keymap.set("n", "<C-PageUp>", "gt")
vim.keymap.set("n", "<C-PageDown>", "gT")

-- Using quickfix
vim.keymap.set("n", "<A-Down>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<A-Up>", "<cmd>cprevious<CR>")

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

nnoremap("<leader>sg", function()
  require("telescope.builtin").live_grep({ hidden = true })
end, { desc = "[S]earch by [G]rep" })

nnoremap("<leader>en", function()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath("config")
  }
end, { desc = "[E]dit [N]eovim" })
nnoremap("<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })

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

-- LSP Keybinds --
M.map_lsp_keybinds = function(buffer_number)
  -- Format the current buffer
  nnoremap("<leader>f", vim.lsp.buf.format, { desc = "Format buffer", buffer = buffer_number })

  nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
  nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })

  nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })

  -- Telescope LSP keybinds --
  nnoremap(
    "gr",
    require("telescope.builtin").lsp_references,
    { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
  )

  nnoremap(
    "gi",
    require("telescope.builtin").lsp_implementations,
    { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
  )

  nnoremap(
    "<leader>bs",
    require("telescope.builtin").lsp_document_symbols,
    { desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number }
  )

  nnoremap(
    "<leader>ps",
    require("telescope.builtin").lsp_workspace_symbols,
    { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number }
  )

  nnoremap("<leader>gl", vim.diagnostic.open_float, { desc = "LSP: Open Diagnostic", buffer = buffer_number })
  nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
  nnoremap("<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
  inoremap("<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })

  -- Lesser used LSP functionality
  nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
  nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end

return M
