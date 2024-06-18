if vim.g.vscode then
  return
end

vim.api.nvim_set_option_value("tabstop", 4, { buf = 0 })
vim.api.nvim_set_option_value("shiftwidth", 4, { buf = 0 })
vim.api.nvim_set_option_value("softtabstop", 4, { buf = 0 })
vim.api.nvim_set_option_value("expandtab", false, { buf = 0 })
