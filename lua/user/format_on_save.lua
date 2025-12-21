-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
-- 	pattern = "*",
-- 	desc = "Run LSP formatting on a file on save",
-- 	callback = function()
-- 		if vim.fn.exists(":Format") > 0 then
-- 			vim.cmd.Format()
-- 		end
-- 	end,
-- })

local group = vim.api.nvim_create_augroup("format_on_save", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*",
  desc = "Format on save (LSP)",
  callback = function(args)
    -- sync format so it finishes before the file is written
    vim.lsp.buf.format({
      bufnr = args.buf,
      async = false,
      timeout_ms = 2000,
    })
  end,
})

