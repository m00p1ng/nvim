vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = vim.api.nvim_create_augroup("disable_autoformat", { clear = true }),
  pattern = {
    "*/lua/config/options.lua",
    "*/lua/plugins/vscode.lua",
    "*/lua/plugins/diffview.lua",
  },
  callback = function()
    vim.b.autoformat = false
  end,
})
