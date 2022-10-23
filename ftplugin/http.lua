local which_key_status_ok, which_key = pcall(require, "which-key")
if not which_key_status_ok then
  return
end

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
    name = "Python",
    r = { "<cmd>lua require'rest-nvim'.run()<cr>", "Run" },
    l = { "<cmd>lua require'rest-nvim'.last()<cr>", "Run Last" },
    p = { "<cmd>lua require'rest-nvim'.run(true)<cr>", "Preview" },
  },
}

which_key.register(mappings, opts)
