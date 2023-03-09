return {
  {
    "tzachar/cmp-tabnine",
    event = "InsertEnter",
    -- build = "./install.sh",
    opts = {
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = "..",
      ignored_file_types = require("utils").ui_filetypes,
      show_prediction_strength = true,
    },
    config = function(_, opts)
      require('cmp_tabnine.config').setup(opts)
    end
  },
  {
    "codota/tabnine-nvim",
    event = "InsertEnter",
    build = "./dl_binaries.sh",
    opts = {
      disable_auto_comment = true,
      accept_keymap = "<C-F>",
      dismiss_keymap = "<C-]>",
      debounce_ms = 800,
      suggestion_color = { gui = "#808080", cterm = 244 },
      exclude_filetypes = require("utils").ui_filetypes,
    },
    config = function(_, opts)
      require("tabnine").setup(opts)
    end,
  },
}
