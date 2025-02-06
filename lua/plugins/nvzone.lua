require("utils").add_ui_ft "typr"

return {
  {
    "nvzone/typr",
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
  },

  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
  },

  {
    "nvzone/minty",
    enabled = false,
    cmd = { "Shades", "Huefy" },
  },
}
