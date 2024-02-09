-- LSP set up
local lsp = require('lsp-zero')

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {'pyright', 'ruff_lsp', 'jsonls'},
})

-- Specific language servers

-- json
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").jsonls.setup({
  capabilities = capabilities,
  init_options = {
    provideFormatter = false
  }
})

vim.g.neoformat_json_prettier = {
  exe = 'prettier',
  args = {'--stdin-filepath', '%:p'},
  stdin = 1,
}
vim.g.neoformat_enabled_json = {'prettier'}
vim.g.neoformat_verbose = 1

-- Python
require("lspconfig").ruff_lsp.setup {}

-- Just for completion, diagnostics disabled
require("lspconfig").pyright.setup({
  settings = {
    pyright = {
      disabled = { "diagnostics" },
    },
  },
})

-- Completion
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
  },
  formatting = lsp.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

-- Format and fix
-- Remember to enable RUFF_EXPERIMENTAL_FORMATTER=true

-- Initialize a variable to control whether formatting should be triggered on save
local enable_formatting = true

-- Function to toggle the formatting state
function ToggleFormatting()
  enable_formatting = not enable_formatting
  if enable_formatting then
    print("Formatting enabled")
  else
    print("Formatting disabled")
  end
end

function Format()
  if enable_formatting then
    vim.lsp.buf.format { async = true }
  else
    print("Formatting disabled")
  end
end

vim.api.nvim_exec([[
  augroup AutoFormat
    autocmd!
    autocmd BufWritePre *.py,*.yaml lua Format()
    autocmd BufWritePre *.json Neoformat
  augroup END
]], true)

-- Example key mapping to toggle formatting
-- vim.keymap.set('n', '<leader>ff', function() vim.lsp.buf.format { async = true } end, bufopts)
vim.keymap.set('n', '<leader>ff', ':lua Format()<CR>')
vim.keymap.set('n', '<leader>ft', ':lua ToggleFormatting()<CR>')
