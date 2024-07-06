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

-- LSP --
vim.keymap.set("n", "gl", "<cmd>lua require('vscode-neovim').call('editor.action.showHover')<cr>")
vim.keymap.set("n", "gi", "<cmd>lua require('vscode-neovim').call('editor.action.revealDeclaration')<cr>")
vim.keymap.set("n", "gr", "<cmd>lua require('vscode-neovim').call('editor.action.referenceSearch.trigger')<cr>")
vim.keymap.set("n", "<leader>a", "<cmd>lua require('vscode-neovim').call('editor.action.quickFix')<cr>")
vim.keymap.set("n", "<leader>lr", "<cmd>lua require('vscode-neovim').call('editor.action.rename')<cr>")
vim.keymap.set("n", "<leader>lf", "<cmd>lua require('vscode-neovim').call('editor.action.formatDocument')<cr>")

-- Navigate --
vim.keymap.set("n", "H", "<cmd>lua require('vscode-neovim').call('workbench.action.previousEditor')<cr>")
vim.keymap.set("n", "L", "<cmd>lua require('vscode-neovim').call('workbench.action.nextEditor')<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>lua require('vscode-neovim').call('workbench.view.explorer')<cr>")

-- Telescope --
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('vscode-neovim').call('workbench.action.quickOpen')<cr>")
vim.keymap.set("n", "<leader>fr", "<cmd>lua require('vscode-neovim').call('workbench.action.quickOpen')<cr>")
vim.keymap.set("n", "<leader>ft", "<cmd>lua require('vscode-neovim').call('workbench.action.findInFiles')<cr>")
vim.keymap.set("v", "<leader>fs", "<cmd>lua require('vscode-neovim').action('workbench.action.findInFiles', { args = { { query = vim.fn.expand('<cword>') } } })<cr>")

-- Utils --
vim.keymap.set("v", "<leader>c", "<cmd>lua require('vscode-neovim').call('execCopy')<cr>")
vim.keymap.set("n", "<leader>c", "<cmd>lua require('vscode-neovim').call('workbench.action.closeActiveEditor')<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>lua require('vscode-neovim').call('workbench.action.closeActiveEditor')<cr>")
vim.keymap.set({ "n", "v" }, "\\e", "<cmd>lua require('vscode-neovim').call('editor.action.commentLine')<cr>")
vim.keymap.set("n", "za", "<cmd>lua require('vscode-neovim').call('editor.toggleFold')<cr>")

-- Git --
vim.keymap.set({ "n", "v" }, "<leader>gs", "<cmd>lua require('vscode-neovim').call('git.stageSelectedRanges')<cr>")
vim.keymap.set({ "n", "v" }, "<leader>gr", "<cmd>lua require('vscode-neovim').call('git.revertSelectedRanges')<cr>")
vim.keymap.set("n", "<leader>gS", "<cmd>lua require('vscode-neovim').call('git.stageAll')<cr>")
vim.keymap.set("n", "<leader>gR", "<cmd>lua require('vscode-neovim').call('workbench.action.files.revert')<cr>")
vim.keymap.set("n", "<leader>gt", "<cmd>lua require('vscode-neovim').call('workbench.view.scm')<cr>")
vim.keymap.set("n", "<leader>gd", "<cmd>lua require('vscode-neovim').call('git.openChange')<cr>")
-- Git Lens --
vim.keymap.set({ "n", "v" }, "<leader>gy", "<cmd>lua require('vscode-neovim').call('gitlens.openFileOnRemote')<cr>")
vim.keymap.set("n", "<leader>gw", "<cmd>lua require('vscode-neovim').call('gitlens.openCommitOnRemote')<cr>")
vim.keymap.set("n", "<leader>gO", "<cmd>lua require('vscode-neovim').call('gitlens.openRepoOnRemote')<cr>")
vim.keymap.set("n", "<leader>gh", "<cmd>lua require('vscode-neovim').call('gitlens.showFileHistoryView')<cr>")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
