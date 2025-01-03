if vim.g.vscode then
  return
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("tsx_eslint_fix", { clear = true }),
  pattern = { "*.tsx" },
  command = "silent! EslintFixAll",
})

local wk = require "which-key"

wk.add {
  { "<leader>m", group = "Typescript" },
  { "<leader>mf", "<cmd>EslintFixAll<cr>", desc = "Fix All", buffer = true },
}
