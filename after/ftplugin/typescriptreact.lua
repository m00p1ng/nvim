if vim.g.vscode then
  return
end

require("which-key").add {
  { "<leader>m", group = "Typescript" },
  { "<leader>mf", "<cmd>EslintFixAll<cr>", desc = "Fix All", buffer = true },
}
