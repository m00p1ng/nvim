local M = {}

local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local has_lsp_file, lsp_file = pcall(require, "lsp-file-operations")

M.capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  has_cmp and cmp_nvim_lsp.default_capabilities() or {},
  has_lsp_file and lsp_file.default_capabilities() or {},
  {
    textDocument = {
      completion = { completionItem = { snippetSupport = true } },
      -- for ufo plugin
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  }
)

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], cond?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], cond?:fun():boolean}

---@return LazyKeysLspSpec[]
function M.get()
  if M._keys then
    return M._keys
  end

  -- stylua: ignore
  M._keys = {
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition", has = "definition" },
    { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
    { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References",nowait = true },
    { "gs", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<c-s>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" },
    { "<leader>a", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    { "<leader>ll", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens"  },
    { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
    { "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },
  }

  return M._keys
end

---@param method string
function M.has(buffer, method)
  method = method:find "/" and method or "textDocument/" .. method
  local clients = vim.lsp.get_clients { bufnr = buffer }
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@return LazyKeysLsp[]
function M.resolve(buffer)
  local Keys = require "lazy.core.handler.keys"
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  local opts = require("utils").opts "nvim-lspconfig"
  local clients = vim.lsp.get_clients { bufnr = buffer }
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require "lazy.core.handler.keys"
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    local has = not keys.has or M.has(buffer, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys)
      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
