return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap-python',
    },
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
    opts = {},
  }
}
