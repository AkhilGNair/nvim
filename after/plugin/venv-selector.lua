local venv = require("venv-selector")

vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<CR>")
vim.keymap.set("n", "<leader>vc", "<cmd>VenvSelectCached<CR>")

venv.setup()

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Auto select virtualenv Nvim open',
  pattern = '*',
  callback = function()
    local venv = vim.fn.findfile('.python-version', vim.fn.getcwd() .. ';')
    if venv ~= '' then
      require('venv-selector').retrieve_from_cache()
    end
  end,
  once = true,
})
