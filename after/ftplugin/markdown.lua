if vim.g.vscode then
  return
end

local wk = require "which-key"

wk.add {
  { "<leader>m", group = "Markdown" },
  { "<leader>mt", "<cmd>Markview toggleAll<cr>", desc = "Toggle Markview", buffer = true },
}
