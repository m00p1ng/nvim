local opts = { noremap = true, silent = true }

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
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
vim.keymap.set("i", ",", ",<c-g>u", opts)
vim.keymap.set("i", ".", ".<c-g>u", opts)
vim.keymap.set("i", ";", ";<c-g>u", opts)
vim.keymap.set("i", ":", ":<c-g>u", opts)

-- ref: https://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
vim.keymap.set("n", "x", '"_x', opts)
vim.keymap.set("n", "dd", function()
  local cur_line = vim.fn.getline "."
  if cur_line == "" or #cur_line == 1 then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- Visual Block --
vim.keymap.set("v", "p", '"_dP', opts)

-- Other --
vim.keymap.set("n", "<cr>", "<cmd>noh<cr>", opts)

local function nvim_mapping()
  -- Normal --
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

  -- Resize with arrows
  vim.keymap.set("n", "<C-Up>", ":resize -2<cr>", opts)
  vim.keymap.set("n", "<C-Down>", ":resize +2<cr>", opts)
  vim.keymap.set("n", "<C-Left>", ":vertical resize -2<cr>", opts)
  vim.keymap.set("n", "<C-Right>", ":vertical resize +2<cr>", opts)

  -- Navigate buffers
  vim.keymap.set("n", "H", "<cmd>bp<cr>", opts)
  vim.keymap.set("n", "L", "<cmd>bn<cr>", opts)

  -- Comment --
  vim.keymap.set("n", "\\e", ":normal gcc<cr>", opts)
  vim.keymap.set("v", "\\e", "<esc>:normal gvgc<cr>", opts)

  -- Other --
  vim.keymap.set("n", "*", "g*``", opts)
  vim.keymap.set("n", "<m-q>", "<cmd>copen<cr>", opts)
end

local function vscode_mapping()
  -- LSP --
  vim.keymap.set("n", "gl", "<cmd>lua require('vscode-neovim').call('editor.action.showHover')<cr>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua require('vscode-neovim').call('editor.action.revealDeclaration')<cr>", opts)
  vim.keymap.set("n", "gr", "<cmd>lua require('vscode-neovim').call('editor.action.referenceSearch.trigger')<cr>", opts)
  vim.keymap.set("n", "<leader>a", "<cmd>lua require('vscode-neovim').call('editor.action.quickFix')<cr>", opts)
  vim.keymap.set("n", "<leader>lr", "<cmd>lua require('vscode-neovim').call('editor.action.rename')<cr>", opts)
  vim.keymap.set("n", "<leader>lf", "<cmd>lua require('vscode-neovim').call('editor.action.formatDocument')<cr>", opts)

  -- Navigate --
  vim.keymap.set("n", "H", "<cmd>lua require('vscode-neovim').call('workbench.action.previousEditor')<cr>", opts)
  vim.keymap.set("n", "L", "<cmd>lua require('vscode-neovim').call('workbench.action.nextEditor')<cr>", opts)
  vim.keymap.set("n", "<leader>e", "<cmd>lua require('vscode-neovim').call('workbench.view.explorer')<cr>", opts)

  -- Telescope --
  vim.keymap.set("n", "<leader>ff", "<cmd>lua require('vscode-neovim').call('workbench.action.quickOpen')<cr>", opts)
  vim.keymap.set("n", "<leader>fr", "<cmd>lua require('vscode-neovim').call('workbench.action.quickOpen')<cr>", opts)
  vim.keymap.set("n", "<leader>ft", "<cmd>lua require('vscode-neovim').call('workbench.action.findInFiles')<cr>", opts)
  vim.keymap.set("v", "<leader>fs", "<cmd>lua require('vscode-neovim').action('workbench.action.findInFiles', { args = { { query = vim.fn.expand('<cword>') } } })<cr>", opts)

  -- Utils --
  vim.keymap.set("v", "<leader>c", "<cmd>lua require('vscode-neovim').call('execCopy')<cr>", opts)
  vim.keymap.set("n", "<leader>c", "<cmd>lua require('vscode-neovim').call('workbench.action.closeActiveEditor')<cr>", opts)
  vim.keymap.set("n", "<leader>q", "<cmd>lua require('vscode-neovim').call('workbench.action.closeActiveEditor')<cr>", opts)
  vim.keymap.set({ "n", "v" }, "\\e", "<cmd>lua require('vscode-neovim').call('editor.action.commentLine')<cr>", opts)
  vim.keymap.set("n", "za", "<cmd>lua require('vscode-neovim').call('editor.toggleFold')<cr>", opts)

  -- Git --
  vim.keymap.set({ "n", "v" }, "<leader>gs", "<cmd>lua require('vscode-neovim').call('git.stageSelectedRanges')<cr>", opts)
  vim.keymap.set({ "n", "v" }, "<leader>gr", "<cmd>lua require('vscode-neovim').call('git.revertSelectedRanges')<cr>", opts)
  vim.keymap.set("n", "<leader>gS", "<cmd>lua require('vscode-neovim').call('git.stageAll')<cr>", opts)
  vim.keymap.set("n", "<leader>gR", "<cmd>lua require('vscode-neovim').call('workbench.action.files.revert')<cr>", opts)
  vim.keymap.set("n", "<leader>gt", "<cmd>lua require('vscode-neovim').call('workbench.view.scm')<cr>", opts)
  vim.keymap.set("n", "<leader>gd", "<cmd>lua require('vscode-neovim').call('git.openChange')<cr>", opts)
  -- Git Lens --
  vim.keymap.set({ "n", "v" }, "<leader>gy", "<cmd>lua require('vscode-neovim').call('gitlens.openFileOnRemote')<cr>", opts)
  vim.keymap.set("n", "<leader>gw", "<cmd>lua require('vscode-neovim').call('gitlens.openCommitOnRemote')<cr>", opts)
  vim.keymap.set("n", "<leader>gO", "<cmd>lua require('vscode-neovim').call('gitlens.openRepoOnRemote')<cr>", opts)
  vim.keymap.set("n", "<leader>gh", "<cmd>lua require('vscode-neovim').call('gitlens.showFileHistoryView')<cr>", opts)
end

if vim.g.vscode == nil then
  nvim_mapping()
else
  vscode_mapping()
end
