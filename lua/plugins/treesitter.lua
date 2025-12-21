return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})
      -- install parsers via Lua API:
      require("nvim-treesitter").install({
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
      })
    end,
  },
}
