local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "notify",
    "query",
    "dap-repl",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "NeogitGitCommandHistory",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  command = "tabdo wincmd =",
})

autocmd("BufEnter", {
  group = augroup("changed_title", { clear = true }),
  callback = function()
    local get_project_dir = function()
      local cwd = vim.fn.getcwd()
      local project_dir = vim.split(cwd, "/")
      local project_name = project_dir[#project_dir]
      return project_name
    end

    vim.opt.titlestring = get_project_dir() .. " - nvim"
  end,
})

autocmd("BufWinEnter", {
  group = augroup("check_file_changed", { clear = true }),
  command = "checktime",
})

autocmd("User", {
  group = augroup("winbar", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    require("utils.winbar").create_winbar()
  end,
})

autocmd("BufReadPost", {
  group = augroup("last_loc", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
