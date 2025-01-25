return (function()
  local C = require("catppuccin.palettes").get_palette "mocha"
  local catppuccin = {}

  local background = C.mantle

  catppuccin.normal = {
    a = { bg = background, fg = C.text },
    b = { bg = background, fg = C.text },
    c = { bg = background, fg = C.text },
    x = { bg = background, fg = C.text },
    y = { bg = background, fg = C.text },
    z = { bg = background, fg = C.text },
  }

  return catppuccin
end)()
