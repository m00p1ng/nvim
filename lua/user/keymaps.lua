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
keymap("n", "<C-h>", ":lua require('Navigator').left()<cr>", opts)
keymap("n", "<C-j>", ":lua require('Navigator').down()<cr>", opts)
keymap("n", "<C-k>", ":lua require('Navigator').up()<cr>", opts)
keymap("n", "<C-l>", ":lua require('Navigator').right()<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<cr>", opts)
keymap("n", "<C-Down>", ":resize +2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":BufferLineCycleNext<cr>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<cr>", opts)
keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<cr>", opts)
keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<cr>", opts)
keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<cr>", opts)
keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<cr>", opts)
keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<cr>", opts)
keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<cr>", opts)
keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<cr>", opts)
keymap("n", "<leader>8", ":BufferLineGoToBuffer 8<cr>", opts)
keymap("n", "<leader>9", ":BufferLineGoToBuffer 9<cr>", opts)
keymap("n", "gb", ":b #<cr>", opts)

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
keymap("v", "<leader>c", '"+y', opts)
keymap("n", "<cr>", ":noh<cr>", opts)
keymap("n", "\\e", ":lua require('Comment.api').toggle_current_linewise()<cr>", opts)
keymap("v", "\\e", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>", opts)
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
keymap("n", "*", "*N", opts)
