vim.g.gitblame_enabled = 1
vim.g.gitblame_date_format = '%r'
vim.g.gitblame_message_template = "   <author>, <date> • <summary>"
vim.g.gitblame_highlight_group = "GitBlame"
vim.g.gitblame_ignored_filetypes = {
  "alpha",
  "NvimTree",
  "DiffviewFiles",
  "DiffviewFileHistory",
  "Trouble",
  "packer",
  "Outline",
  "NeogitPopup",
  "NeogitStatus",
  "NeogitCommitPopup",
  "NeogitCommitMessage",
}
vim.g.gitblame_set_extmark_options = {
  ['priority'] = 10000,
}
