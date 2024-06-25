local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
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
keymap("i", ",", ",<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", ";", ";<c-g>u", opts)
keymap("i", ":", ":<c-g>u", opts)

-- ref: https://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
keymap("n", "x", '"_x', opts)
keymap("n", "dd", function()
  local cur_line = vim.fn.getline "."
  if cur_line == "" or #cur_line == 1 then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- Visual Block --
keymap("v", "p", '"_dP', opts)

-- Other --
keymap("n", "<cr>", "<cmd>noh<cr>", opts)

local function nvim_mapping()
  -- Normal --
  keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

  -- Resize with arrows
  keymap("n", "<C-Up>", ":resize -2<cr>", opts)
  keymap("n", "<C-Down>", ":resize +2<cr>", opts)
  keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
  keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

  -- Navigate buffers
  keymap("n", "H", "<cmd>bp<cr>", opts)
  keymap("n", "L", "<cmd>bn<cr>", opts)

  -- Other --
  keymap("n", "*", "g*``", opts)
  keymap("n", "<m-q>", "<cmd>copen<cr>", opts)

  -- Comment --
  keymap("n", "\\e", ":normal gcc<cr>", opts)
  keymap("v", "\\e", "<esc>:normal gvgc<cr>", opts)
end

local function vscode_mapping()
  -- LSP --
  keymap("n", "gl", "<cmd>lua require('vscode-neovim').call('editor.action.showHover')<cr>", opts)
  keymap("n", "gi", "<cmd>lua require('vscode-neovim').call('editor.action.revealDeclaration')<cr>", opts)
  keymap("n", "gr", "<cmd>lua require('vscode-neovim').call('editor.action.referenceSearch.trigger')<cr>", opts)
  keymap("n", "<leader>a", "<cmd>lua require('vscode-neovim').call('editor.action.quickFix')<cr>", opts)
  keymap("n", "<leader>lr", "<cmd>lua require('vscode-neovim').call('editor.action.rename')<cr>", opts)
  keymap("n", "<leader>lf", "<cmd>lua require('vscode-neovim').call('editor.action.formatDocument')<cr>", opts)

  -- Navigate --
  keymap("n", "H", "<cmd>lua require('vscode-neovim').call('workbench.action.previousEditor')<cr>", opts)
  keymap("n", "L", "<cmd>lua require('vscode-neovim').call('workbench.action.nextEditor')<cr>", opts)
  keymap("n", "<leader>e", "<cmd>lua require('vscode-neovim').call('workbench.view.explorer')<cr>", opts)

  -- Telescope --
  keymap("n", "<leader>ff", "<cmd>lua require('vscode-neovim').call('workbench.action.quickOpen')<cr>", opts)
  keymap("n", "<leader>fr", "<cmd>lua require('vscode-neovim').call('workbench.action.quickOpen')<cr>", opts)
  keymap("n", "<leader>ft", "<cmd>lua require('vscode-neovim').call('workbench.action.findInFiles')<cr>", opts)
  keymap(
    "v",
    "<leader>fs",
    "<cmd>lua require('vscode-neovim').action('workbench.action.findInFiles', { args = { { query = vim.fn.expand('<cword>') } } })<cr>",
    opts
  )

  -- Utils --
  keymap("v", "<leader>c", "<cmd>lua require('vscode-neovim').call('execCopy')<cr>", opts)
  keymap("n", "<leader>c", "<cmd>lua require('vscode-neovim').call('workbench.action.closeActiveEditor')<cr>", opts)
  keymap("n", "<leader>q", "<cmd>lua require('vscode-neovim').call('workbench.action.closeActiveEditor')<cr>", opts)
  keymap({ "n", "v" }, "\\e", "<cmd>lua require('vscode-neovim').call('editor.action.commentLine')<cr>", opts)
  keymap("n", "za", "<cmd>lua require('vscode-neovim').call('editor.toggleFold')<cr>", opts)
  keymap("n", "\\j", "<cmd>lua require('treesj').split()<cr>", opts)
  keymap("n", "\\J", "<cmd>lua require('treesj').join()<cr>", opts)

  -- Git --
  keymap({ "n", "v" }, "<leader>gs", "<cmd>lua require('vscode-neovim').call('git.stageSelectedRanges')<cr>", opts)
  keymap({ "n", "v" }, "<leader>gr", "<cmd>lua require('vscode-neovim').call('git.revertSelectedRanges')<cr>", opts)
  keymap("n", "<leader>gS", "<cmd>lua require('vscode-neovim').call('git.stageAll')<cr>", opts)
  keymap("n", "<leader>gR", "<cmd>lua require('vscode-neovim').call('workbench.action.files.revert')<cr>", opts)
  keymap("n", "<leader>gt", "<cmd>lua require('vscode-neovim').call('workbench.view.scm')<cr>", opts)
  keymap("n", "<leader>gd", "<cmd>lua require('vscode-neovim').call('git.openChange')<cr>", opts)
  -- Git Lens --
  keymap({ "n", "v" }, "<leader>gy", "<cmd>lua require('vscode-neovim').call('gitlens.openFileOnRemote')<cr>", opts)
  keymap("n", "<leader>gw", "<cmd>lua require('vscode-neovim').call('gitlens.openCommitOnRemote')<cr>", opts)
  keymap("n", "<leader>gO", "<cmd>lua require('vscode-neovim').call('gitlens.openRepoOnRemote')<cr>", opts)
  keymap("n", "<leader>gh", "<cmd>lua require('vscode-neovim').call('gitlens.showFileHistoryView')<cr>", opts)
end

if vim.g.vscode == nil then
  nvim_mapping()
else
  vscode_mapping()
end
