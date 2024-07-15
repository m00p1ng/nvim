return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = false,
        suggestions = 20,
      },
      presets = {
        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    popup_mappings = {
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },
    window = {
      border = "rounded",
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 2, 2, 2, 2 },
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "left",
    },
    ignore_missing = true,
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    show_help = true,
    triggers = "auto",
    triggers_blacklist = {
      i = { "j", "k" },
      v = { "j", "k" },
    },
  },
  config = function(_, opts)
    local which_key = require "which-key"

    local n_opts = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local n_mappings = {
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      q = { "<cmd>q!<cr>", "Quit" },
      Q = { "<cmd>qall!<cr>", "Quit All" },
      c = { "<cmd>bd<cr>", "Close Buffer" },
      O = { "<cmd>%bd|e#|bd#<cr>", "Buffer Only" },
      n = { "<cmd>Noice<cr>", "Noice" },
      N = { "<cmd>NoiceLast<cr>", "Noice" },

      p = {
        name = "Lazy",
        c = { "<cmd>Lazy check<cr>", "Check" },
        C = { "<cmd>Lazy clean<cr>", "Clean" },
        i = { "<cmd>Lazy install<cr>", "Install" },
        s = { "<cmd>Lazy sync<cr>", "Sync" },
        u = { "<cmd>Lazy update<cr>", "Update" },
      },

      d = {
        name = "Debug",
      },

      f = {
        name = "Find",
      },

      g = {
        name = "Git",
        g = { "<cmd>Neogit<cr>", "Neogit" },
      },

      l = {
        name = "LSP",
        -- f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
        f = { "<cmd>lua require('conform').format({async = true, lsp_fallback = true})<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>Mason<cr>", "Installer Info" },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        L = { "<cmd>LspLensToggle<cr>", "Toggle Lens" },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        o = { "<cmd>Outline<cr>", "Outline" },
        R = { "<cmd>LspRestart<cr>", "Restart" },
        k = { "<cmd>FormatDisable<cr>", "Disable Format" },
        K = { "<cmd>FormatDisable!<cr>", "Disable Format (Buffer)" },
        j = { "<cmd>FormatEnable<cr>", "Enable Format" },
      },
    }

    which_key.setup(opts)
    which_key.register(n_mappings, n_opts)
  end,
}
