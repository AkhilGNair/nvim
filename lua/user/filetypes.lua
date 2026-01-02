-- lua/user/filetypes.lua
vim.filetype.add({
  pattern = {
    ['.*/templates/.*%.ya?ml']  = 'helm',
    ['.*/templates/.*%.tpl']    = 'helm',
    ['.*/templates/.*%.gotmpl'] = 'helm',
    ['.*/_helpers%.tpl']        = 'helm',
    ['.*/values.*%.yaml']       = 'yaml.helm-values',
  }
})
