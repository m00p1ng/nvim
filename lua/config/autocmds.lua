local f = require "utils"

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("CmdWinEnter", {
  group = vim.api.nvim_create_augroup("cmdline_mapping", { clear = true }),
  callback = function(event)
    vim.opt_local.colorcolumn = {}
    vim.keymap.set("n", "<cr>", "<cr>", { buffer = event.buf })
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
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd "checktime"
    end
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

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("set_tab_instead_space", { clear = true }),
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("very_lazy_init", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    vim.api.nvim_create_autocmd("InsertEnter", {
      group = vim.api.nvim_create_augroup("set_color_column", { clear = true }),
      callback = function()
        if f.is_ui_filetype(vim.bo.ft) then
          return
        end
        vim.opt_local.colorcolumn = { "80", "100", "120" }
      end,
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
      group = vim.api.nvim_create_augroup("unset_color_column", { clear = true }),
      callback = function()
        if f.is_ui_filetype(vim.bo.ft) then
          return
        end
        vim.opt_local.colorcolumn = {}
      end,
    })

    require("utils.winbar").create_winbar()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("git_keymap", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.keymap.set("i", "<C-s>", function()
      local result = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }):wait()
      if result.code ~= 0 then
        vim.notify("Git repository not found", vim.log.levels.WARN)
        return
      end
      local branch = vim.trim(result.stdout)
      vim.api.nvim_feedkeys(branch, "i", false)
    end, { expr = true })
  end,
})
