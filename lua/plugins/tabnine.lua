return {
  {
    "tzachar/cmp-tabnine",
    event = "InsertEnter",
    opts = {
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = "..",
      ignored_file_types = {
        -- default is not to ignore
        ["dap-repl"] = true,
        dapui_watches = true,
      },
      show_prediction_strength = true,
    },
  },
  {
    "codota/tabnine-nvim",
    event = "InsertEnter",
    build = "./dl_binaries.sh",
    config = function()
      require("tabnine").setup {
        disable_auto_comment = true,
        accept_keymap = "<Tab>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt" },
      }
    end,
  },
}
