require("utils").add_ui_ft "typr"

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
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
  },

  {
    "nvzone/minty",
    enabled = false,
    cmd = { "Shades", "Huefy" },
  },
}
