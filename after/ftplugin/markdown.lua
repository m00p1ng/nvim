if vim.g.vscode then
  return
end

require("which-key").add {
  { "<leader>m", group = "Markdown" },
  { "<leader>mt", "<cmd>Markview toggleAll<cr>", desc = "Toggle Markview", buffer = true },
}
