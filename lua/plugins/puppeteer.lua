return {
  "chrisgrieser/nvim-puppeteer",
  ft = { "lua", "python", "javascript", "typescript" },
  init = function()
    vim.g.puppeteer_disable_filetypes = require("utils").ui_filetypes
  end,
}
