-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
--   pattern = "*",
--   desc = "Run LSP formatting on a file on save",
--   callback = function()
--     if vim.fn.exists(":Format") > 0 then
--       vim.cmd.Format()
--     else
--       -- Fallback to LSP formatting if :Format isn't defined
--       pcall(vim.lsp.buf.format, { bufnr = bufnr, timeout_ms = 2000 })
--     end
--   end,
-- })

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    format_on_save = function(bufnr)
      -- Disable for big files
      local max = 200 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size > max then
        return
      end
      return { lsp_fallback = true, timeout_ms = 2000 }
    end,
  }
}
