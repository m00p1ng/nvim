M = {}

local function clear_screen()
  vim.fn.system "tmux send-keys -R C-l\\; clear-history"
  vim.fn.system "tmux send-keys C-u"
end

local function select_pane()
  vim.fn.system "tmux select-pane -t-"
end

local function send_command(cmd)
  cmd = cmd:gsub("'", "\\'")
  print(cmd)
  vim.fn.system("tmux send-keys " .. "'" .. cmd .. "' Enter")
end

local function get_total_panes()
  local result = vim.fn.system "tmux display -p '#{window_panes}'"
  return tonumber(result)
end

local function create_pane()
  vim.fn.system "tmux split-window -h -c '#{pane_current_path}'"
end

local function is_copy_mode()
  local result = vim.fn.system "tmux display-message -p -F '#{pane_in_mode}'"
  return tonumber(result) == 1
end

local function exit_copy_mode()
  vim.fn.system "tmux send-keys C-c"
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
