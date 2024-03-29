return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  cond = vim.g.vscode == nil,
  opts = {
    window = {
      backdrop = 1,
      height = 1,
      -- width = 0.5,
      width = 100,
      options = {
        signcolumn = "no",
        number = false,
        relativenumber = false,
        cursorline = true,
        cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      gitsigns = { enabled = false },
      tmux = { enabled = false },
      twilight = { enabled = false },
    },
    on_open = function()
      vim.g.cmp_active = false
      vim.cmd [[LspStop]]
      local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", nil, { scope = "local" })
      if not status_ok then
        return
      end
      if vim.fn.exists("#" .. "_winbar") == 1 then
        vim.cmd("au! " .. "_winbar")
      end
    end,
    on_close = function()
      vim.g.cmp_active = true
      vim.cmd [[LspStart]]
      require("plugins.winbar").create_winbar()
    end,
  },
}
