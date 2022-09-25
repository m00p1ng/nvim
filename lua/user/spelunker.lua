vim.g.spelunker_highlight_type = 0
vim.g.spelunker_check_type = 2
vim.g.spelunker_disable_auto_group = 1
vim.g.spelunker_ignored_filetypes = {
  "alpha",
  "NvimTree",
  "DiffviewFiles",
  "DiffviewFileHistory",
  "qf",
  "packer",
  "lspinfo",
  "toggleterm",
  "Outline",
  "NeogitCommitPopup",
  "NeogitStatus",
  "mason",
  "dapui_watches",
  "dapui_stacks",
  "dapui_breakpoints",
  "dapui_scopes",
  "dap-repl",
}

vim.cmd [[
  highlight SpelunkerSpellBad gui=undercurl guisp=#4FC1FF guifg=NONE
  highlight SpelunkerComplexOrCompoundWord gui=undercurl guisp=#4FC1FF guifg=NONE
]]
