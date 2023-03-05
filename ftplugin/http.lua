if require("utils").has "rest.nvim" then
  local which_key = require "which-key"
  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local mappings = {
    m = {
      name = "Rest",
      r = { "<cmd>lua require'rest-nvim'.run()<cr>", "Run" },
      l = { "<cmd>lua require'rest-nvim'.last()<cr>", "Run Last" },
      p = { "<cmd>lua require'rest-nvim'.run(true)<cr>", "Preview" },
    },
  }

  which_key.register(mappings, opts)
end
