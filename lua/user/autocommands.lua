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
  command = "nnoremap <silent> <buffer> q :lua require('user.function').close_diffview()<cr>",
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

local spelunker_group = augroup("_spelunker", { clear = true })
autocmd("CursorHold", {
  callback = function()
    local filetype = vim.api.nvim_buf_get_option(0, 'ft')
    if vim.tbl_contains(vim.g.spelunker_ignored_filetypes, filetype) then
      return
    end

    vim.cmd [[
      call spelunker#check_displayed_words()
    ]]
  end,
  group = spelunker_group,
})
