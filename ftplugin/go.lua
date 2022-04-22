vim.api.nvim_buf_set_option(0, "tabstop", 4)
vim.api.nvim_buf_set_option(0, "shiftwidth", 4)
vim.api.nvim_buf_set_option(0, "softtabstop", 4)
vim.api.nvim_buf_set_option(0, "expandtab", false)

local go_group = vim.api.nvim_create_augroup("_go", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
    vim.lsp.buf.formatting()
  end,
  group = go_group,
})

