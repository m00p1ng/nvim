local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general_group = augroup("_general_settings", { clear = true })
autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "notify"
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      nnoremap <silent> <buffer> <esc> :close<CR>
      set nobuflisted
    ]]
  end,
  group = general_group
})
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end,
  group = general_group
})
autocmd("VimEnter", {
  command = "ab Dopen DiffviewOpen",
  group = general_group
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
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

    vim.cmd [[ call spelunker#check_displayed_words() ]]
  end,
  group = spelunker_group,
})

local js_group = augroup("_js_eslint_fix", { clear = true })
autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
  command = "EslintFixAll",
  group = js_group,
})

local fix_luasnip_group = augroup("_fix_luasnaip", { clear = true })
autocmd({ "InsertLeave" }, {
  callback = function()
    local luasnip = require "luasnip"
    if luasnip.expand_or_jumpable() then
      luasnip.unlink_current()
    end
  end,
  group = fix_luasnip_group,
})

local changed_title = augroup("_changed_title", { clear = true })
autocmd({ "BufEnter" }, {
  pattern = { "" },
  callback = function()
    local get_project_dir = function()
      local cwd = vim.fn.getcwd()
      local project_dir = vim.split(cwd, "/")
      local project_name = project_dir[#project_dir]
      return project_name
    end

    vim.opt.titlestring = get_project_dir() .. " - nvim"
  end,
  group = changed_title
})

local auto_check_file_changed = augroup("_auto_check_file_changed", { clear = true })
autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
  group = auto_check_file_changed
})
