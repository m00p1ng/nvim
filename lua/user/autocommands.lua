local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general_group = augroup("_general_settings", { clear = true })
autocmd("FileType", {
  pattern = { "qf", "help", "man", "lspinfo" },
  command = "nnoremap <silent> <buffer> q :close<cr>",
  group = general_group
})
autocmd("FileType", {
  pattern = { "DiffviewFiles", "DiffviewFileHistory" },
  command = "nnoremap <silent> <buffer> q :lua require('user.function').toggle_diffview()<cr>",
  group = general_group
})
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end,
  group = general_group
})

local auto_resize_group = augroup("_auto_resize", { clear = true })
autocmd("VimResized", {
  command = "tabdo wincmd =",
  group = auto_resize_group,
})

local illuminate_group = augroup("_illuminate", { clear = true })
autocmd("VimEnter", {
  command = "hi link illuminatedWord LspReferenceText",
  group = illuminate_group,
})

local go_group = augroup("_go", { clear = true })
autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
    vim.lsp.buf.formatting()
  end,
  group = go_group,
})
autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.api.nvim_buf_set_option(0, "tabstop", 4)
    vim.api.nvim_buf_set_option(0, "shiftwidth", 4)
    vim.api.nvim_buf_set_option(0, "softtabstop", 4)
    vim.api.nvim_buf_set_option(0, "expandtab", false)
  end,
  group = go_group,
})

local spelunker_group = augroup("_spelunker", { clear = true })
autocmd("CursorHold", {
  callback = function()
    require('user.function').init_spelunker()
  end,
  group = spelunker_group,
})
