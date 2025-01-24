return {
  "chrisgrieser/nvim-puppeteer",
  lazy = false, -- plugin lazy-loads itself. Can also load on filetypes.
  init = function()
    vim.g.puppeteer_disable_filetypes = require("utils").ui_filetypes
  end,
}
