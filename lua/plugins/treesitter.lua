return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    event = { "BufEnter" },
    dependencies = {
      -- Additional text objects for treesitter
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      ---@diagnostic disable: missing-fields
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "vim",
          "python",
          "helm"
          -- "yaml", This is currently borked see: https://github.com/ikatyang/tree-sitter-yaml/issues/53
        },
        sync_install = false,
        indent = {
          enable = true,
        },
        highlight = {
          enable = true,
        },
      })
    end,
  },
}
