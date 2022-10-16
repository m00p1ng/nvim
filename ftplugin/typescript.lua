local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local status_ok, dap_vscode_js = pcall(require, "dap-vscode-js")
if not status_ok then
  return
end

local installation_path = vim.fn.stdpath("data") .. "/mason/packages"

dap_vscode_js.setup({
  adapters = { 'pwa-node' },
  debugger_path = installation_path .. '/js-debug-adapter'
})

dap.configurations.typescript = {
  {
    name = 'Attach',
    type = 'pwa-node',
    request = 'attach',
    port = 9229,
    cwd = '${workspaceFolder}',
  },
  {
    name = 'Launch',
    type = 'pwa-node',
    request = 'launch',
    program = '${file}',
    cwd = '${workspaceFolder}',
  },
}
