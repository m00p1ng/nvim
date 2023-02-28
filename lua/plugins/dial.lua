return {
  "monaqa/dial.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local dial_config = require "dial.config"
    local augend = require "dial.augend"
    dial_config.augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
      },
      visual = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
      },
      mygroup = {
        augend.constant.new {
          elements = { "and", "or" },
          word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
          cyclic = true, -- "or" is incremented into "and".
        },
        augend.constant.new {
          elements = { "True", "False" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "public", "private" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "let", "const" },
        },
        augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
        augend.constant.alias.bool, -- boolean value (true <-> false)
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.semver.alias.semver,
        augend.hexcolor.new {
          case = "upper",
        },
      },
    }
  end,
  keys = function()
    local f = require "utils."
    if f.has "dial" == false then
      return {}
    end

    local map = require "dial.map"

    return {
      { "<C-a>", map.inc_normal "mygroup", mode = "n", noremap = true },
      { "<C-x>", map.dec_normal "mygroup", mode = "n", noremap = true },
      { "<C-a>", map.inc_normal "visual", mode = "v", noremap = true },
      { "<C-x>", map.dec_normal "visual", mode = "v", noremap = true },
      { "g<C-a>", map.inc_gvisual "visual", mode = "v", noremap = true },
      { "g<C-x>", map.dec_gvisual "visual", mode = "v", noremap = true },
    }
  end,
}
