local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", opts)
keymap("n", "gb", ":b #<CR>", opts)

-- Visual Block --
-- Better pasted
keymap("v", "p", '"_dP', opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Other --
keymap("v",  "ç", '"+y', opts)
keymap("n", "<CR>", ":noh<CR>", opts)
keymap("n", "\\e", ":lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("v", "\\e", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)
keymap("n", "]h", ":lua require 'gitsigns'.next_hunk()<cr>", opts)
keymap("n", "[h", ":lua require 'gitsigns'.prev_hunk()<cr>", opts)
keymap("n", "\\r", ":lua require 'rest-nvim'.run()<cr>", opts)
keymap("n", "]t", ":tabnext<cr>", opts)
keymap("n", "[t", ":tabprev<cr>", opts)
keymap(
  "n",
  "z=",
  "<cmd>lua require('telescope.builtin').spell_suggest(require('telescope.themes').get_cursor{previewer=false,layout_config={height=14}})<cr>",
  opts
)
