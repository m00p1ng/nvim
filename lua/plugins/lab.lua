return {
  "0x100101/lab.nvim",
  build = "cd js && npm ci",
  event = "InsertEnter",
  cond = vim.g.vscode == nil,
  opts = {
    code_runner = {
      enabled = true,
    },
    quick_data = {
      enabled = true,
    },
  },
  config = function(_, opts)
    require("lab").setup(opts)
  end,
}
