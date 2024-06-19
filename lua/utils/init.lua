local M = {}

M.ui_filetypes = {
  "alpha",
  "help",
  "qf",
  "",
  "notfile",
  "quickfix",
  "lazy",
  "NvimTree",
  "NeogitStatus",
  "NeogitPopup",
  "NeogitCommitPopup",
  "NeogitCommitMessage",
  "NeogitConsole",
  "NeogitNotification",
  "NeogitGitCommandHistory",
  "DiffviewFiles",
  "DiffviewFileHistory",
  "Outline",
  "TelescopePrompt",
  "lspinfo",
  "mason",
  "dapui_watches",
  "dapui_stacks",
  "dapui_breakpoints",
  "dapui_scopes",
  "dapui_hover",
  "dapui_console",
  "dap-repl",
  "neotest-summary",
  "neotest-output",
  "noice",
  "startuptime",
  "notify",
  "DressingInput",
}

function M.cmd(args, cwd)
  local result = { stdout = {}, stderr = {} }
  local job = vim.fn.jobstart(args, {
    cwd = cwd,
    on_stdout = function(chanid, data, name)
      for _, line in ipairs(data) do
        if string.len(line) > 0 then
          table.insert(result.stdout, line)
        end
      end
    end,
    on_stderr = function(chanid, data, name)
      for _, line in ipairs(data) do
        if string.len(line) > 0 then
          table.insert(result.stderr, line)
        end
      end
    end,
  })
  vim.fn.jobwait { job }
  return result
end

function M.is_ui_filetype(value, opts)
  opts = opts or {}
  local include = opts.include
  local exclude = opts.exclude

  if include ~= nil then
    return vim.tbl_contains(include, value)
  end

  if exclude ~= nil then
    return not vim.tbl_contains(exclude, value)
  end

  return vim.tbl_contains(M.ui_filetypes, value)
end

function M.clear_prompt()
  vim.api.nvim_command "normal! :<cr>"
end

function M.get_user_input_char()
  local c = vim.fn.getchar()
  while type(c) ~= "number" do
    c = vim.fn.getchar()
  end
  return vim.fn.nr2char(c)
end

function M.is_empty(s)
  return s == nil or s == ""
end

function M.find_index(source, value)
  for k, v in pairs(source) do
    if v == value then
      return k
    end
  end
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_get_option_value, opt, { buf = 0 })
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

function M.project_files(opts)
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

function M.get_visual_selection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg "v"
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require "lazy.core.plugin"
  return Plugin.values(plugin, "opts", false)
end

function M.grep_at_current_tree_node()
  local node = require("nvim-tree.lib").get_node_at_cursor()
  if not node then
    return
  end
  require("telescope.builtin").live_grep { search_dirs = { node.absolute_path } }
end

return M
