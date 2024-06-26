return {
  {
    "tzachar/cmp-tabnine",
    event = "InsertEnter",
    build = "./install.sh",
    opts = {
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = "..",
      ignored_file_types = require("utils").ui_filetypes,
      show_prediction_strength = true,
    },
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
      suggestion_color = { gui = "#b668cd", cterm = 244 },
      codelens_color = { gui = "#b668cd", cterm = 244 },
      codelens_enabled = false,
      exclude_filetypes = require("utils").ui_filetypes,
      log_file_path = nil,
      tabnine_enterprise_host = nil,
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "TabnineSuggestion", { fg = opts.suggestion_color.gui })

      require("tabnine").setup(opts)
    end,
  },
}
