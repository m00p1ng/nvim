vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = vim.api.nvim_create_augroup("disable_autoformat", { clear = true }),
  pattern = {
    "*/lua/plugins/nvim-neo-tree.lua",
    "*/lua/plugins/vscode.lua",
  },
  callback = function()
    vim.b.autoformat = false
  end,
})
