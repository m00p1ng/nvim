vim.api.nvim_buf_set_option(0, "tabstop", 4)
vim.api.nvim_buf_set_option(0, "shiftwidth", 4)
vim.api.nvim_buf_set_option(0, "softtabstop", 4)
vim.api.nvim_buf_set_option(0, "expandtab", false)

local function org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

local go_group = vim.api.nvim_create_augroup("_go", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
    vim.lsp.buf.format { async = true }
    org_imports(3000)
  end,
  group = go_group,
})

local dap = require "dap"

local installation_path = vim.fn.stdpath "data" .. "/mason/packages"

dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = installation_path .. "/delve/dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug Package",
    request = "launch",
    program = "${fileDirname}",
  },
  {
    type = "delve",
    name = "Attach",
    mode = "local",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

if require("utils").has "gopher.nvim" then
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
      name = "Golang",
      t = { "<cmd>GoTagAdd<cr>", "Tag Add" },
      T = { "<cmd>GoTagRm<cr>", "Tag remove" },
      m = { "<cmd>GoMod tidy<cr>", "Mod tidy" },
      c = { "<cmd>GoCmt<cr>", "Comment" },
    },
  }

  which_key.register(mappings, opts)
end
