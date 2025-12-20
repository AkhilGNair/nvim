return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true
          },
          grep_string = {
            additional_args = { "--hidden" }
          },
          live_grep = {
            additional_args = { "--hidden" }
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-x>"] = actions.delete_buffer,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            "yarn.lock",
            ".git",
          },
          hidden = true,
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Enable telescope fzf native, if installed
      -- pcall(require("telescope").load_extension, "fzf")
      require("telescope").load_extension("fzf")
    end,
  },
}
