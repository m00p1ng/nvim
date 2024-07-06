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
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
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
        b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Breakpoint" },
        B = {
          "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
          "Conditional breakpoint",
        },
        L = {
          "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
          "Log breakpoint",
        },
        c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
        i = { "<cmd>lua require('dap').step_into()<cr>", "Into" },
        o = { "<cmd>lua require('dap').step_over()<cr>", "Over" },
        O = { "<cmd>lua require('dap').step_out()<cr>", "Out" },
        r = { "<cmd>lua require('dap').repl.toggle()<cr>", "Repl" },
        l = { "<cmd>lua require('dap').run_last()<cr>", "Last" },
        e = { "<cmd>lua require('dapui').eval()<cr>", "Eval" },
        u = { "<cmd>lua require('dapui').toggle()<cr>", "UI" },
        x = { "<cmd>lua require('dap').terminate()<cr>", "Exit" },
      },

      f = {
        name = "Find",
        S = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>lua require('utils.telescope').project_files()<cr>", "Find files" },
        -- t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        t = { "<cmd>Telescope live_grep_args theme=ivy<cr>", "Find Text (Args)" },
        s = { "<cmd>Telescope grep_string<cr>", "Find String" },
        h = { "<cmd>Telescope help_tags<cr>", "Help" },
        H = { "<cmd>Telescope highlights<cr>", "Highlight" },
        l = { "<cmd>Telescope resume<cr>", "Last Search" },
        m = { "<cmd>Telescope marks<cr>", "Marks" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        c = { "<cmd>Telescope command_history<cr>", "Command History" },
        N = { "<cmd>Telescope notify theme=dropdown<cr>", "Notify" },
        V = { "<cmd>Telescope vim_options<cr>", "Vim Options" },
        j = { "<cmd>Telescope jumplist<cr>", "Jump list" },
        o = { "<cmd>Telescope symbols<cr>", "Symbols" },
      },

      g = {
        name = "Git",
        l = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Blame" },
        P = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
        r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
        R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
        s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
        S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Buffer" },
        u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches show_remote_tracking_branches=false<cr>", "Checkout branch" },
        B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        C = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = { "<cmd>Gitsigns diffthis<cr>", "Diff" },
        t = { "<cmd>DiffviewOpen<cr>", "Diff view" },
        h = { "<cmd>DiffviewFileHistory %<cr>", "File History" },
        g = { "<cmd>Neogit<cr>", "Neogit" },
        D = { "<cmd>Telescope diffview<cr>", "Compare HEAD" },
        p = { "<cmd>lua require('utils.git').previous_change()<cr>", "Diff Previous" },
      },

      l = {
        name = "LSP",
        d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Diagnostics" },
        w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
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
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
      },
    }

    -- Visual Options
    local v_opts = {
      mode = "v",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local v_mappings = {
      g = {
        name = "Git",
        r = { ":Gitsigns reset_hunk<cr>", "Reset Hunk" },
        s = { ":Gitsigns stage_hunk<cr>", "Stage Hunk" },
      },
      f = {
        name = "Find",
        s = {
          "<cmd>lua require('telescope.builtin').live_grep({ default_text = require('utils').get_visual_selection() })<cr>",
          "Find String",
        },
      },
    }

    which_key.setup(opts)
    which_key.register(n_mappings, n_opts)
    which_key.register(v_mappings, v_opts)
  end,
}
