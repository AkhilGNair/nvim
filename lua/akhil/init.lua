require("akhil.remap")

local home = os.getenv("HOME")

vim.g.python3_host_prog = home .. "/.pyenv/versions/pynvim/bin/python"

vim.o.wildmenu = true
vim.o.wildmode = "longest:full"

vim.wo.relativenumber = true
vim.wo.number = true

