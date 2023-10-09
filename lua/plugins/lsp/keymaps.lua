local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
  if not M._keys then
  ---@class PluginLspKeys
    -- stylua: ignore
    M._keys =  {
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gs", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "<c-s>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
      { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "[d", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
      { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
      -- { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    }
  end
  return M._keys
end

---@param method string
function M.has(buffer, method)
  method = method:find "/" and method or "textDocument/" .. method
  local clients = require("utils").get_clients { bufnr = buffer }
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@return (LazyKeys|{has?:string})[]
function M.resolve(buffer)
  local Keys = require "lazy.core.handler.keys"
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  local opts = require("utils").opts "nvim-lspconfig"
  local clients = require("utils").get_clients { bufnr = buffer }
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
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
