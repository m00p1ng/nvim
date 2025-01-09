if not vim.g.vscode then
  return {}
end

local enabled = {
  "LazyVim",
  "dial.nvim",
  "vim-repeat",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "treesj",
}

local Config = require "lazy.core.config"
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

local function vscode_call(action)
  return "<cmd>lua require('vscode-neovim').call('" .. action .. "')<cr>"
end

-- LSP --
vim.keymap.set("n", "gl", vscode_call "editor.action.showHover")
vim.keymap.set("n", "gi", vscode_call "editor.action.revealDeclaration")
vim.keymap.set("n", "gr", vscode_call "editor.action.referenceSearch.trigger")
vim.keymap.set("n", "<leader>a", vscode_call "editor.action.quickFix")
vim.keymap.set("n", "<leader>lr", vscode_call "editor.action.rename")
vim.keymap.set("n", "<leader>lf", vscode_call "editor.action.formatDocument")

-- Navigate --
vim.keymap.set("n", "H", vscode_call "workbench.action.previousEditor")
vim.keymap.set("n", "L", vscode_call "workbench.action.nextEditor")
vim.keymap.set("n", "<leader>e", vscode_call "workbench.view.explorer")

-- Telescope --
vim.keymap.set("n", "<leader>b", vscode_call "workbench.action.showAllEditors")
vim.keymap.set("n", "<leader><leader>", vscode_call "workbench.action.quickOpen")
vim.keymap.set("n", "<leader>fr", vscode_call "workbench.action.quickOpen")
vim.keymap.set("n", "<leader>ft", vscode_call "workbench.action.findInFiles")
vim.keymap.set({ "n", "v" }, "<leader>fs", "<cmd>lua require('vscode-neovim').action('workbench.action.findInFiles', { args = { { query = vim.fn.expand('<cword>') } } })<cr>")

-- Utils --
vim.keymap.set("v", "<leader>c", vscode_call "execCopy")
vim.keymap.set("n", "<leader>c", vscode_call "workbench.action.closeActiveEditor")
vim.keymap.set("n", "<leader>q", vscode_call "workbench.action.closeActiveEditor")
vim.keymap.set({ "n", "v" }, "<localleader>e", vscode_call "editor.action.commentLine")
vim.keymap.set("n", "za", vscode_call "editor.toggleFold")

-- Git --
vim.keymap.set({ "n", "v" }, "<leader>gs", vscode_call "git.stageSelectedRanges")
vim.keymap.set({ "n", "v" }, "<leader>gr", vscode_call "git.revertSelectedRanges")
vim.keymap.set("n", "<leader>gS", vscode_call "git.stageAll")
vim.keymap.set("n", "<leader>gR", vscode_call "workbench.action.files.revert")
vim.keymap.set("n", "<leader>gt", vscode_call "workbench.view.scm")
vim.keymap.set("n", "<leader>gd", vscode_call "git.openChange")
-- Git Lens --
vim.keymap.set({ "n", "v" }, "<leader>gy", vscode_call "gitlens.openFileOnRemote")
vim.keymap.set("n", "<leader>gw", vscode_call "gitlens.openCommitOnRemote")
vim.keymap.set("n", "<leader>gO", vscode_call "gitlens.openRepoOnRemote")
vim.keymap.set("n", "<leader>gh", vscode_call "gitlens.showFileHistoryView")

-- Other --
vim.keymap.set("n", "<leader>O", vscode_call "workbench.action.closeOtherEditors")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
