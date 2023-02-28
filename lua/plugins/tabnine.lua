return {
  "tzachar/cmp-tabnine",
  event = "InsertEnter",
  opts = {
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
    ignored_file_types = { -- default is not to ignore
      ["dap-repl"] = true,
      dapui_watches = true,
    },
    show_prediction_strength = true,
  },
}
