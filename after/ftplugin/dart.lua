if vim.g.vscode then
  return
end

require("which-key").add {
  { "<leader>m", group = "Flutter" },
  { "<leader>mt", "<cmd>Telescope flutter commands<cr>", desc = "Menu", buffer = true },
  { "<leader>mf", "<cmd>Telescope flutter fvm<cr>", desc = "FVM", buffer = true },
}
