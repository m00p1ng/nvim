if vim.g.vscode then
  return
end

vim.b.last_ref = nil

local function get_cmd(ref)
  local cmd = ("python '%s'"):format(vim.fn.expand "%:~:.")
  if ref then
    cmd = ("%s %s"):format(cmd, ref)
  end

  return cmd
end

require("which-key").add {
  { "<leader>m", group = "Python" },
  {
    "<leader>mr",
    function()
      local cmd = get_cmd()
      require("utils.tmux").run(cmd)
    end,
    desc = "Run",
    buffer = true,
  },
  {
    "<leader>mt",
    function()
      vim.b.last_ref = require("utils.treesitter").get_ref()
      local cmd = get_cmd(vim.b.last_ref)
      require("utils.tmux").run(cmd)
    end,
    desc = "Run Cursor",
    buffer = true,
  },
  {
    "<leader>ml",
    function()
      local cmd = get_cmd(vim.b.last_ref)
      require("utils.tmux").run(cmd)
    end,
    desc = "Run Last",
    buffer = true,
  },
}
