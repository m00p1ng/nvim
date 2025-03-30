--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

-- Normal --
-- ref: https://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "dd", function()
  local cur_line = vim.fn.getline "."
  if cur_line == "" or #cur_line == 1 then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

vim.keymap.set("v", "c", '"_c')
vim.keymap.set("v", "C", '"_C')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Visual Block --
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<leader>c", '"+y', { desc = "Copy to System Clipboard" })

-- Search --
vim.keymap.set("n", "*", "g*``", { desc = "Search Current Word" })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Resize with arrows
-- vim.keymap.set("n", "<C-Up>", ":resize -2<cr>", { desc = "Increase Window Height" })
-- vim.keymap.set("n", "<C-Down>", ":resize +2<cr>", { desc = "Decrease Window Height" })
-- vim.keymap.set("n", "<C-Left>", ":vertical resize -2<cr>", { desc = "Decrease Window Width" })
-- vim.keymap.set("n", "<C-Right>", ":vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Navigate Tabs
vim.keymap.set("n", "[t", "<cmd>tabprev<cr>", { desc = "Prev Tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next Tab" })

-- Other --
vim.keymap.set("n", "<m-q>", "<cmd>copen<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<cr>", "<cmd>noh<cr>", { desc = "Clear Search" })
vim.keymap.set("n", "<leader>q", "<cmd>q!<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qall!<cr>", { desc = "Quit All" })
vim.keymap.set("n", "<leader>c", "<cmd>bd<cr>", { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>O", "<cmd>%bd|e#|bd#<cr>", { desc = "Buffer Only" })
vim.keymap.set("n", "<leader>M", "<cmd>messages<cr>", { desc = "Messages" })

-- if vim.lsp.inlay_hint then
--   vim.keymap.set("n", "<leader>lu", function()
--     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 })
--   end, { desc = "Toggle Inlay Hints" })
-- end
