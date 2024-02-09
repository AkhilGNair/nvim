return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "█", right = "█" },
        },
        sections = {
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "filetype" },
          lualine_z = {
            {
              function()
                if vim.bo.filetype == 'python' then
                  return require('lualine.components.venv-selector').update_status()
                else
                  return ''
                end
              end,
              icon = ' ',
            },
          },
        },
      })
    end,
  },
}

-- 'venv-selector', icon = ' '
