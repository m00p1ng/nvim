if vim.g.vscode then
  return
end

require("which-key").add {
  { "<leader>m", group = "Markdown" },
}
