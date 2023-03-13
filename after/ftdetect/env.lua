vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env.*", "*.env" },
  callback = function()
    vim.cmd "set filetype=sh"
    vim.diagnostic.disable(0)
  end,
})
