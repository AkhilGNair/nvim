-- Set a global python version for the LSP

-- Platform independent directory separator
local sep = package.config:sub(1, 1) -- \ or /

local home = os.getenv("HOME")
vim.g.python3_host_prog = home .. "/.pyenv/versions/pynvim/bin/python"

local venv_selector = require("venv-selector")

vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<CR>")
vim.keymap.set("n", "<leader>vc", "<cmd>VenvSelectCached<CR>")

venv_selector.setup({
  search = true,
  notify_user_on_activate = true,
  name = { "venv", ".venv" },
  stay_on_this_version = true
})

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Auto select virtualenv Nvim open',
  pattern = '*',
  callback = function()
    local venv = vim.fn.findfile('.python-version', vim.fn.getcwd() .. ';')
    if venv ~= '' then
      venv_selector.retrieve_from_cache()
    end
  end,
  once = true,
})
