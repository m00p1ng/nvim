vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "terraform.tfstate", "terraform.tfstate.backup" },
  command = "set syntax=json",
})
