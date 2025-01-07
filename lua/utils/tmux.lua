M = {}

-- output "'0'\n"
local function stdout_to_number(str)
  return tonumber(vim.trim(str:gsub("'", "")))
end

local function clear_screen()
  vim.system({ "tmux", "send-keys", "-R", "C-l;", "clear-history" }):wait()
  vim.system({ "tmux", "send-keys", "C-u" }):wait()
end

local function select_pane()
  vim.system({ "tmux", "select-pane", "-t-" }):wait()
end

local function send_command(cmd)
  vim.notify(cmd)
  vim.system({ "tmux", "send-keys", cmd, "Enter" }):wait()
end

local function get_total_panes()
  local result = vim.system({ "tmux", "display", "-p", "'#{window_panes}'" }):wait().stdout
  return stdout_to_number(result)
end

local function create_pane()
  vim.system({ "tmux", "split-window", "-h", "-p", "40", "-c", "'#{pane_current_path}'" }):wait()
end

local function is_copy_mode()
  local result = vim.system({ "tmux", "display", "-p", "'#{pane_in_mode}'" }, { text = true }):wait().stdout
  local val = stdout_to_number(result)
  return val == 1
end

local function exit_copy_mode()
  vim.system({ "tmux", "send-keys", "C-c" }):wait()
end

M.run_command = function(cmd)
  if get_total_panes() > 1 then
    select_pane()
  else
    create_pane()
  end

  if is_copy_mode() then
    exit_copy_mode()
  end

  clear_screen()
  send_command(cmd)
  select_pane()
end

return M
