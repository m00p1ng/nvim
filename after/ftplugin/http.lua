if vim.g.vscode then
  return
end

local wk = require "which-key"

wk.add {
  { "<leader>m", group = "Typescript" },
  { "<leader>mr", "<cmd>lua require('kulala').run()<cr>", desc = "Send Request" },
  { "<leader>ml", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay" },
  { "<leader>mf", "<cmd>lua require('kulala').from_curl()<cr>", desc = "From cURL" },
  { "<leader>mc", "<cmd>lua require('kulala').copy()<cr>", desc = "To cURL" },
  { "[r", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Prev req" },
  { "]r", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Next req" },
}
