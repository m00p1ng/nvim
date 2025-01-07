if vim.g.vscode then
  return
end

require("which-key").add {
  { "<leader>m", group = "Typescript" },
  { "<leader>mr", "<cmd>lua require('kulala').run()<cr>", desc = "Send Request", buffer = true },
  { "<leader>ml", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay", buffer = true },
  { "<leader>mf", "<cmd>lua require('kulala').from_curl()<cr>", desc = "From cURL", buffer = true },
  { "<leader>mc", "<cmd>lua require('kulala').copy()<cr>", desc = "To cURL", buffer = true },
  { "[r", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Prev req", buffer = true },
  { "]r", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Next req", buffer = true },
}
