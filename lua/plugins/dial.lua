return {
  "monaqa/dial.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local dial_config = require "dial.config"
    local augend = require "dial.augend"
    local map = require "dial.map"

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

    -- change augends in VISUAL mode
    vim.api.nvim_set_keymap("n", "<C-a>", map.inc_normal "mygroup", { noremap = true })
    vim.api.nvim_set_keymap("n", "<C-x>", map.dec_normal "mygroup", { noremap = true })
    vim.api.nvim_set_keymap("v", "<C-a>", map.inc_normal "visual", { noremap = true })
    vim.api.nvim_set_keymap("v", "<C-x>", map.dec_normal "visual", { noremap = true })
    vim.api.nvim_set_keymap("v", "g<C-a>", map.inc_gvisual "visual", { noremap = true })
    vim.api.nvim_set_keymap("v", "g<C-x>", map.dec_gvisual "visual", { noremap = true })
  end,
}
