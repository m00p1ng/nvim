local f = require "utils"

local function mapped_filetype(l)
  local res = {}
  for _, v in pairs(l) do
    res[v] = ""
  end

  return res
end

local ftMap = vim.tbl_extend("force", mapped_filetype(f.ui_filetypes), {
  vim = { "treesitter", "indent" },
  sh = { "treesitter", "indent" },
  git = { "treesitter", "indent" },
  conf = { "treesitter", "indent" },
  yaml = { "treesitter", "indent" },
  markdown = "",
})

return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = { "BufReadPost", "BufNewFile" },
  commit = "42be3ce3903c26bb753586958e403877ad36b9f6",
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
