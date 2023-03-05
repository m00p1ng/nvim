local M = {}

M.ui_filetypes = {
  "alpha",
  "NvimTree",
  "help",
  "",
  "lazy",
  "NeogitStatus",
  "NeogitPopup",
  "NeogitCommitPopup",
  "NeogitCommitMessage",
  "NeogitConsole",
  "DiffviewFiles",
  "DiffviewFileHistory",
  "Outline",
  "qf",
  "TelescopePrompt",
  "lspinfo",
  "mason",
  "dapui_watches",
  "dapui_stacks",
  "dapui_breakpoints",
  "dapui_scopes",
  "dapui_hover",
  "dap-repl",
  "neotest-summary",
  "noice",
  "startuptime",
  "neo-tree",
  "neo-tree-popup",
  "DressingInput",
}

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

function M.smart_quit(quit)
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    print "You have unsaved changes. Quit anyway? (y/N) "
    local input = M.get_user_input_char()

    if input == "y" then
      if quit == true then
        vim.cmd "q!"
      else
        vim.cmd "Bdelete!"
      end
    end

    M.clear_prompt()
  else
    if quit == true then
      vim.cmd "q!"
    else
      vim.cmd "Bdelete!"
    end
  end
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

function M.get_buf_list()
  return vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then
      return false
    end

    return true
  end, vim.api.nvim_list_bufs())
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
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

function M.get_git_commit_sha()
  require("gitblame").copy_sha_to_clipboard()
  return vim.fn.getreg "+"
end

function M.git_previous_change()
  local sha = M.get_git_commit_sha()
  vim.api.nvim_command(":DiffviewOpen " .. sha .. "^!")
end

local function parse_git_url(remote_url)
  local domain, path = string.match(remote_url, ".*git%@(.*)%:(.*)%.git")
  if domain and path then
    return "https://" .. domain .. "/" .. path
  end

  local url = string.match(remote_url, ".*git%@(.*)%.git")
  if url then
    return "https://" .. url
  end

  local https_url = string.match(remote_url, "(https%:%/%/.*)%.git")
  if https_url then
    return https_url
  end

  -- Don't have .git extension
  domain, path = string.match(remote_url, ".*git%@(.*)%:(.*)")
  if domain and path then
    return "https://" .. domain .. "/" .. path
  end

  url = string.match(remote_url, ".*git%@(.*)")
  if url then
    return "https://" .. url
  end

  https_url = string.match(remote_url, "(https%:%/%/.*)")
  if https_url then
    return https_url
  end
end

function M.open_git_commit_on_web()
  local sha = M.get_git_commit_sha()
  local commit_path = "/commit/" .. sha

  require("gitblame.git").get_remote_url(function(remote_url)
    local url = parse_git_url(remote_url) .. commit_path
    require("gitblame.utils").launch_url(url)
  end)
end

function M.open_git_project_on_web()
  require("gitblame.git").get_remote_url(function(remote_url)
    local url = parse_git_url(remote_url)
    require("gitblame.utils").launch_url(url)
  end)
end

function M.getVisualSelection()
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
      local buffer = args.buf
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

return M
