return {
  "f-person/git-blame.nvim",
  enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  cond = vim.g.vscode == nil,
  config = function()
    vim.g.gitblame_enabled = 1
    vim.g.gitblame_date_format = "%r"
    vim.g.gitblame_message_template = "   <author>, <date> • <summary>"
    vim.g.gitblame_message_when_not_committed = "  You, now • Uncommitted changes"
    vim.g.gitblame_highlight_group = "GitBlame"
    vim.g.gitblame_ignored_filetypes = require("utils").ui_filetypes
    vim.g.gitblame_set_extmark_options = {
      ["priority"] = 10000,
    }
  end,
}
