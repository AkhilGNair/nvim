vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    local max_bytes = 200 * 1024 -- 200 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
    if ok and stats and stats.size > max_bytes then
      return
    end
    pcall(vim.treesitter.start, ev.buf)
  end,
})
