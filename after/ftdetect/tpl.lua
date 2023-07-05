vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tpl" },
  command = "set syntax=yaml",
})

