vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
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
    "NeogitGitCommandHistory",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  command = "tabdo wincmd =",
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("changed_title", { clear = true }),
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

vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("check_file_changed", { clear = true }),
  command = "checktime",
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("winbar", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    require("utils.winbar").create_winbar()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
