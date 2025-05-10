return {
  "lukas-reineke/virt-column.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    char = "│",
    -- virtcolumn = "80,100,120",
    highlight = "VirtColumn",
    exclude = {
      filetypes = require("utils").ui_filetypes,
    },
  },
}
