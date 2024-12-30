local ftMap = {
  vim = { "treesitter", "indent" },
  sh = { "treesitter", "indent" },
  git = { "treesitter", "indent" },
  conf = { "treesitter", "indent" },
  yaml = { "treesitter", "indent" },
  markdown = "",

  snacks_dashboard = "",
  NvimTree = "",
  ["neo-tree"] = "",
  ["neo-tree-popup"] = "",
  help = "",
  lazy = "",
  NeogitStatus = "",
  NeogitPopup = "",
  NeogitCommitPopup = "",
  NeogitCommitMessage = "",
  DiffviewFiles = "",
  DiffviewFileHistory = "",
  Outline = "",
  qf = "",
  TelescopePrompt = "",
  lspinfo = "",
  mason = "",
  dapui_watches = "",
  dapui_stacks = "",
  dapui_breakpoints = "",
  dapui_scopes = "",
  dapui_hover = "",
  ["dap-repl"] = "",
}

return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.foldnestmax = 2

    local ufo = require "ufo"

    local function customizeSelector(bufnr)
      local function handleFallbackException(err, providerName)
        if type(err) == "string" and err:match "UfoFallbackException" then
          return ufo.getFolds(providerName, bufnr)
        else
          return require("promise").reject(err)
        end
      end

      return ufo
        .getFolds("lsp", bufnr)
        :catch(function(err)
          return handleFallbackException(err, "treesitter")
        end)
        :catch(function(err)
          return handleFallbackException(err, "indent")
        end)
    end

    ufo.setup {
      provider_selector = function(bufnr, filetype, buftype)
        return ftMap[filetype] or customizeSelector
      end,
    }
  end,
}
