local opts = { noremap = true }
vim.api.nvim_buf_set_keymap(0, "n", "rr", ":lua require'rest-nvim'.run()<cr>", opts)
vim.api.nvim_buf_set_keymap(0, "n", "rl", ":lua require'rest-nvim'.last()<cr>", opts)
vim.api.nvim_buf_set_keymap(0, "n", "rp", ":lua require'rest-nvim'.run(true)<cr>", opts)
