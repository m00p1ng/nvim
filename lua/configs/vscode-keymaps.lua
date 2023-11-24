local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Insert --
-- Add undo break-points
keymap("i", ",", ",<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", ";", ";<c-g>u", opts)
keymap("i", ":", ":<c-g>u", opts)

-- Other --
keymap("n", "<cr>", "<cmd>noh<cr>", opts)

-- LSP --
keymap("n", "gl", "<cmd>lua require('vscode-neovim').call('editor.action.showHover')<cr>", opts)
keymap("n", "gi", "<cmd>lua require('vscode-neovim').call('editor.action.revealDeclaration')<cr>", opts)
keymap("n", "<leader>lr", "<cmd>lua require('vscode-neovim').call('editor.action.rename')<cr>", opts)

-- Navigate --
keymap("n", "H", "<cmd>lua require('vscode-neovim').call('workbench.action.previousEditor')<cr>", opts)
keymap("n", "L", "<cmd>lua require('vscode-neovim').call('workbench.action.nextEditor')<cr>", opts)
