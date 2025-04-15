return {
  {
    "nvzone/typr",
    enabled = false,
    dependencies = "nvzone/volt",
    opts = {
      insert_on_start = true,
      kblayout = "colemak",
      wpm_goal = 60,
    },
    cmd = { "Typr", "TyprStats" },
  },
  {
    "nvzone/typr",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("setup_typr", { clear = true }),
        pattern = "typr",
        callback = function()
          vim.b.completion = false
        end,
      })
    end,
    init = function()
      require("utils").add_ui_ft "typr"
    end,
  },

  {
    "nvzone/showkeys",
    enabled = false,
    cmd = "ShowkeysToggle",
  },

  {
    "nvzone/minty",
    enabled = false,
    cmd = { "Shades", "Huefy" },
  },
}
