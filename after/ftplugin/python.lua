if vim.g.vscode then
  return
end

require("which-key").add {
  { "<leader>m", group = "Python" },
  {
    "<leader>mr",
    function()
      local cmd = "python3 '" .. vim.fn.expand "%:~:." .. "'"
      require("utils.tmux").run_command(cmd)
    end,
    desc = "Run",
    buffer = true,
  },
  {
    "<leader>mt",
    function()
      local cmd = "python3 '" .. vim.fn.expand "%:~:." .. "'"
      cmd = cmd .. " " .. require("utils.treesitter").get_ref()
      require("utils.tmux").run_command(cmd)
    end,
    desc = "Run Cursor",
    buffer = true,
  },
  {
    "<leader>ml",
    function()
      local cmd = "python3 '" .. vim.fn.expand "%:~:." .. "'"
      cmd = cmd .. " " .. require("utils.treesitter").last_ref
      require("utils.tmux").run_command(cmd)
    end,
    desc = "Run Last",
    buffer = true,
  },
}
