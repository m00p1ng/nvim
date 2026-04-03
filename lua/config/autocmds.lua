local f = require "utils"

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "qf",
    "help",
    "lspinfo",
    "nvim-undotree",
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
    -- vim.opt_local.colorcolumn = {}
    vim.keymap.set("n", "<cr>", "<cr>", { buffer = event.buf })
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- vim.api.nvim_create_autocmd("TextYankPost", {
--   group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
--   callback = function()
--     vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
--   end,
-- })

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  command = "tabdo wincmd =",
  call,
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

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("very_lazy_init", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    vim.api.nvim_create_autocmd("InsertEnter", {
      group = vim.api.nvim_create_augroup("set_color_column", { clear = true }),
      callback = function()
        if not f.is_ui_filetype(vim.bo.ft) then
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

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      group = vim.api.nvim_create_augroup("unset_color_column", { clear = true }),
      callback = function()
        if not f.is_ui_filetype(vim.bo.ft) then
          return
        end
        vim.opt_local.statuscolumn = ""
      end,
    })

    require("utils.winbar").create_winbar()

    -- add undotree to packpath
    vim.cmd.packadd { "nvim.undotree" }
    require("utils").add_ui_ft "nvim-undotree"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("undotree_settings", { clear = true }),
  pattern = "nvim-undotree",
  callback = function()
    vim.opt_local.number = false

    local winbar = require "utils.winbar"
    winbar.add_show_cond(function(opts)
      if opts.ft == "nvim-undotree" then
        return true
      end
    end)
    winbar.add_rename_cond(function(opts)
      if opts.ft == "nvim-undotree" then
        return {
          file_icon = "󰙅",
          output_filename = "Undotree",
        }
      end
    end)
  end,
})

-- Ref: https://www.reddit.com/r/neovim/comments/1rcvliq/ghostty_lsp_progress_bar/
-- vim.api.nvim_create_autocmd("LspProgress", {
--   callback = function(ev)
--     local value = ev.data.params.value or {}
--     if not value.kind then
--       return
--     end
--
--     local status = value.kind == "end" and 0 or 1
--     local percent = value.percentage or 0
--
--     local osc_seq = string.format("\27]9;4;%d;%d\a", status, percent)
--
--     if os.getenv "TMUX" then
--       osc_seq = string.format("\27Ptmux;\27%s\27\\", osc_seq)
--     end
--
--     io.stdout:write(osc_seq)
--     io.stdout:flush()
--   end,
-- })
