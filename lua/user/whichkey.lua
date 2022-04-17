local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
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
}

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["Q"] = { "<cmd>qall!<CR>", "Quit All" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  d = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    B = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Conditional breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
  },

  f = {
    name = "Find",
    C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = {
      "<cmd>lua require('user.function').project_files(require('telescope.themes').get_dropdown{previewer=false,hidden=true})<cr>",
      "Find files",
    },
    t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    H = { "<cmd>Telescope highlights<cr>", "Highlight" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    m = { "<cmd>Telescope marks<cr>", "Marks"},
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = {
      "<cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown{previewer=false})<cr>",
      "Recent File",
    },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    N = { "<cmd>Telescope notify<cr>", "Notify" },
    V = { "<cmd>Telescope vim_options<cr>", "Vim Options" },
  },

  g = {
    name = "Git",
    l = { "<cmd>GitBlameToggle<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    C = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>Gitsigns diffthis<cr>", "Diff" },
    t = {
      "<cmd>lua require('user.function').toggle_diffview()<cr>",
      "Toggle diff view",
    },
    h = {
      "<cmd>lua require('user.function').toggle_diffview_file_history()<cr>",
      "Toggle File History",
    },
    c = {
      "<cmd>lua require('neogit').open({ 'commit' })<cr>",
      "Commit"
    },
    g = {
      "<cmd>lua require('neogit').open()<cr>",
      "Neogit"
    }
  },

  l = {
    name = "LSP",
    a = {
      "<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor{previewer=false,layout_config={height=14}})<cr>",
      "Code Action",
    },
    d = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics" },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    R = { "<cmd>Trouble lsp_references<cr>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    v = {
      "<cmd>lua require'toggle_lsp_diagnostics'.toggle_virtual_text()<cr>",
      "Toggle virtual text"
    }
  },

  t = {
    name = "Terminal",
    ["1"] = { ":1ToggleTerm<cr>", "1" },
    ["2"] = { ":2ToggleTerm<cr>", "2" },
    ["3"] = { ":3ToggleTerm<cr>", "3" },
    ["4"] = { ":4ToggleTerm<cr>", "4" },
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },

  T = {
    name = "Treesitter",
    h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
    p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
  },

  z = {
    name = "Spelunker",
    c = { ":call spelunker#correct()<cr>", "Correct current word" },
    C = { ":call spelunker#correct_all()<cr>", "Correct all words" },
    f = { ":call spelunker#correct_feeling_lucky()<cr>", "Correct current word" },
    F = { ":call spelunker#correct_all_feeling_lucky()<cr>", "Correct all words" },
    g = { ":call spelunker#execute_with_target_word('spellgood')<cr> :call spelunker#check()<cr>", "Spell good" },
    G = { ":call spelunker#execute_with_target_word('spellgood!')<cr> :call spelunker#check()<cr>", "Temp spell good" },
    w = { ":call spelunker#execute_with_target_word('spellwrong')<cr> :call spelunker#check()<cr>", "Spell bad" },
    W = { ":call spelunker#execute_with_target_word('spellwrong!')<cr> :call spelunker#check()<cr>", "Temp spell bad" },
    N = { ":call spelunker#jump_next()<cr>", "Next spell" },
    P = { ":call spelunker#jump_prev()<cr>", "Prev spell" },
    T = { ":call spelunker#toggle()<cr>", "Toggle spell check" },
    t = { ":call spelunker#toggle_buffer()<cr>", "Toggle current spell check" },
    u = {
      name = "Undo",
      g = { ":call spelunker#execute_with_target_word('spellundo')<cr> :call spelunker#check()<cr>", "Spell good" },
      G = { ":call spelunker#execute_with_target_word('spellundo!')<cr> :call spelunker#check()<cr>", "Temp Spell good" },
      w = { ":call spelunker#execute_with_target_word('spellundo')<CR> :call spelunker#check()<cr>", "Spell wrong" },
      W = { ":call spelunker#execute_with_target_word('spellundo!')<CR> :call spelunker#check()<cr>", "Temp Spell wrong" },
    },
  }
}

which_key.setup(setup)
which_key.register(mappings, opts)
