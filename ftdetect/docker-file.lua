vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "Dockerfile.*",
  command = "set filetype=dockerfile",
})
