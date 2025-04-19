return {
  "lukas-reineke/virt-column.nvim",
  opts = {
    char = "│",
    -- virtcolumn = "80,100,120",
    highlight = "VirtColumn",
    exclude = {
      filetypes = require("utils").ui_filetypes,
    },
  },
}
