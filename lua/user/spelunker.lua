vim.g.spelunker_highlight_type = 0
vim.g.spelunker_check_type = 2
vim.g.spelunker_disable_auto_group = 1
vim.g.spelunker_ignored_filetypes = {
  "alpha",
  "dashboard",
  "NvimTree",
  "Outline",
  "DiffviewFiles",
  "Trouble",
  "spectre_panel",
  "packer",
}

vim.cmd [[
  highlight SpelunkerSpellBad gui=undercurl guisp=#4FC1FF guifg=NONE
  highlight SpelunkerComplexOrCompoundWord gui=undercurl guisp=#4FC1FF guifg=NONE
]]
