vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env.*", "*.env" },
  callback = function()
    vim.diagnostic.enable(false)
  end,
})
