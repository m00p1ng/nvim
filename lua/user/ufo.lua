vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldnestmax = 2

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})
