local icons = require "utils.icons"

return {
  "SmiteshP/nvim-navic",
  lazy = true,
  cond = vim.g.vscode == nil,
  opts = {
    icons = {
      File = icons.documents.File .. " ",
      Module = icons.kind.Module .. " ",
      Namespace = icons.kind.Class .. " ",
      Package = icons.ui.Package .. " ",
      Class = icons.kind.Class .. " ",
      Method = icons.kind.Method .. " ",
      Property = icons.kind.Property .. " ",
      Field = icons.kind.Field .. " ",
      Constructor = icons.kind.Constructor .. " ",
      Enum = icons.kind.Enum .. " ",
      Interface = icons.kind.Interface .. " ",
      Function = icons.kind.Function .. " ",
      Variable = icons.kind.Variable .. " ",
      Constant = icons.kind.Constant .. " ",
      String = icons.type.String .. " ",
      Number = icons.type.Number .. " ",
      Boolean = icons.type.Boolean .. " ",
      Array = icons.type.Array .. " ",
      Object = icons.type.Object .. " ",
      -- Key = ' ',
      -- Null = ' ',
      EnumMember = icons.kind.EnumMember .. " ",
      Struct = icons.kind.Struct .. " ",
      Event = icons.kind.Event .. " ",
      Operator = icons.kind.Operator .. " ",
      TypeParameter = icons.kind.TypeParameter .. " ",
    },
    highlight = true,
    separator = " " .. icons.ui.ChevronRight .. " ",
    depth_limit = 5,
    depth_limit_indicator = "..",
  },
  init = function()
    vim.g.navic_silence = true
    require("utils").on_attach(function(client, buffer)
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, buffer)
      end
    end)
  end,
}
