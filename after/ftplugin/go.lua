if vim.g.vscode then
  return
end

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false

local function org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("_go", { clear = true }),
  pattern = { "*.go" },
  callback = function()
    vim.lsp.buf.format { async = true }
    org_imports(3000)
  end,
})

require("dap-go").setup()

if require("utils").has "gopher.nvim" then
  require("which-key").add {
    { "<leader>m", group = "Golang" },
    { "<leader>mj", "<cmd>GoTagAdd json -transform camelcase<cr>", desc = "Tag Add (JSON)", buffer = true },
    { "<leader>mJ", "<cmd>GoTagRm json<cr>", desc = "Tag Remove (JSON)", buffer = true },
    { "<leader>mb", "<cmd>GoTagAdd bson -transform camelcase<cr>", desc = "Tag Add (BSON)", buffer = true },
    { "<leader>mB", "<cmd>GoTagRm bson<cr>", desc = "Tag Remove (BSON)", buffer = true },
    { "<leader>mm", "<cmd>GoMod tidy<cr>", desc = "Mod Tidy", buffer = true },
    { "<leader>mc", "<cmd>GoCmt<cr>", desc = "Comment", buffer = true },
  }
end
