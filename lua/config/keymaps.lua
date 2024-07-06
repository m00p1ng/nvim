--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Insert --
-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")
vim.keymap.set("i", ":", ":<c-g>u")

-- ref: https://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "dd", function()
  local cur_line = vim.fn.getline "."
  if cur_line == "" or #cur_line == 1 then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- Normal --
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Visual Block --
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("v", "<space>c", '"+y', { desc = "Copy to System Clipboard" })

-- Search --
vim.keymap.set("n", "*", "g*``", { desc = "Search Current Word" })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Other --
vim.keymap.set("n", "<cr>", "<cmd>noh<cr>", { desc = "Clear Search" })

local function nvim_mapping()
  -- Resize with arrows
  vim.keymap.set("n", "<C-Up>", ":resize -2<cr>", { desc = "Increase Window Height" })
  vim.keymap.set("n", "<C-Down>", ":resize +2<cr>", { desc = "Decrease Window Height" })
  vim.keymap.set("n", "<C-Left>", ":vertical resize -2<cr>", { desc = "Decrease Window Width" })
  vim.keymap.set("n", "<C-Right>", ":vertical resize +2<cr>", { desc = "Increase Window Width" })

  -- Navigate buffers
  vim.keymap.set("n", "H", "<cmd>bp<cr>", { desc = "Prev Buffer" })
  vim.keymap.set("n", "L", "<cmd>bn<cr>", { desc = "Next Buffer" })

  -- Navigate Tabs
  vim.keymap.set("n", "[t", "<cmd>tabprev<cr>", { desc = "Prev Tab" })
  vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next Tab" })

  -- Comment --
  vim.keymap.set("n", "\\e", ":normal gcc<cr>", { desc = "Toggle Comment" })
  vim.keymap.set("v", "\\e", "<esc>:normal gvgc<cr>", { desc = "Toggle Comment" })

  -- Other --
  vim.keymap.set("n", "<m-q>", "<cmd>copen<cr>", { desc = "Quickfix List" })
end

local function vscode_mapping()
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
end

if vim.g.vscode == nil then
  nvim_mapping()
else
  vscode_mapping()
end
