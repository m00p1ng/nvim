local status_ok, navigator = pcall(require, "Navigator")
if not status_ok then
  return
end

navigator.setup {
  disable_on_zoom = true,
}

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-h>", ":lua require('Navigator').left()<cr>", opts)
vim.keymap.set("n", "<C-j>", ":lua require('Navigator').down()<cr>", opts)
vim.keymap.set("n", "<C-k>", ":lua require('Navigator').up()<cr>", opts)
vim.keymap.set("n", "<C-l>", ":lua require('Navigator').right()<cr>", opts)
