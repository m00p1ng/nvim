M = {}

M.clear_screen = function ()
  vim.fn.system("tmux send-keys -R C-l\\; clear-history")
  vim.fn.system("tmux send-keys C-u")
end

M.select_pane = function ()
  vim.fn.system("tmux select-pane -t-")
end

M.send_command = function (cmd)
  cmd = cmd:gsub("'", "\\'")
  print(cmd)
  vim.fn.system("tmux send-keys " .. "'" .. cmd .. "' Enter")
end

M.run_command = function (cmd)
  M.select_pane()
  M.clear_screen()
  M.send_command(cmd)
end

return M
