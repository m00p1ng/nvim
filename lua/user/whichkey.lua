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
  a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
  b = { "<cmd>Telescope buffers<cr>", "Buffers" },
  q = { "<cmd>lua require('user.function').smart_quit(true)<cr>", "Quit" },
  Q = { "<cmd>qall!<cr>", "Quit All" },
  e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  c = { "<cmd>lua require('user.function').smart_quit(false)<cr>", "Close Buffer" },
  O = { "<cmd>%bd|e#|bd#<cr>", "Buffer Only" },
  z = { "<cmd>ZenMode<cr>", "Zen" },

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
    b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Breakpoint" },
    B = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Conditional breakpoint" },
    L = { "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Log breakpoint" },
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
    f = { "<cmd>lua require('user.function').project_files()<cr>", "Find files" },
    t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    T = { "<cmd>Telescope live_grep_args theme=ivy<cr>", "Find Text (Args)" },
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
  },

  g = {
    name = "Git",
    l = { "<cmd>GitBlameToggle<cr>", "Toggle Blame" },
    P = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
    S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Buffer" },
    u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    C = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>Gitsigns diffthis<cr>", "Diff" },
    t = { "<cmd>DiffviewOpen<cr>", "Diff view" },
    h = { "<cmd>DiffviewFileHistory %<cr>", "File History" },
    g = { "<cmd>Neogit<cr>", "Neogit" },
    D = { "<cmd>Telescope diffview<cr>", "Compare HEAD" },
    w = { "<cmd>lua require('user.function').open_git_commit_on_web()<cr>", "Open Commit on Web" },
    O = { "<cmd>lua require('user.function').open_git_project_on_web()<cr>", "Open Project on Web" },
    p = { "<cmd>lua require('user.function').git_previous_change()<cr>", "Diff Previous" },
  },

  l = {
    name = "LSP",
    -- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Diagnostics" },
    w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Installer Info" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    R = { "<cmd>LspRestart<cr>", "Restart" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
  },

  t = {
    name = "Test",
    O = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Open Summary" },
    o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Show Output" },
    r = { "<cmd>lua require('neotest').run.run()<cr>", "Run" },
    R = { "<cmd>lua require('neotest').run.run({ strategy = 'dap' }))<cr>", "Run (DAP)" },
    l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
    L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Run Last (DAP)" },
    f = { "<cmd>lua require('neotest').run.run({ vim.fn.expand('%') })<cr>", "Run File" },
    F = { "<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' })<cr>", "Run File (DAP)" },
    s = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
  },

  T = {
    name = "Treesitter",
    H = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
    p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
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
  c = { '"+y', "Copy" },
  g = {
    name = "Git",
    r = { ":Gitsigns reset_hunk<cr>", "Reset Hunk" },
    s = { ":Gitsigns stage_hunk<cr>", "Stage Hunk" },
  }
}

-- Backslash Options
local backslash_opts = {
  mode = "n",
  prefix = "\\",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local backslash_mappings = {
  e = { "<cmd>lua require('Comment.api').locked('toggle.linewise.current')()<cr>", "Comment" },
  j = { "<cmd>lua require('spread').out()<cr>", "Break Line" },
  J = { "<cmd>lua require('spread').combine()<cr>", "Join Line" },
}

-- Visual Backslash Options
local v_backslash_opts = {
  mode = "v",
  prefix = "\\",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local v_backslash_mappings = {
  e = { ":lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<cr>", "Comment" },
  r = { ":lua require('telescope').extensions.refactoring.refactors()<cr>", "Refactoring" },
}

-- Prev Bracket
local prev_bracket_opts = {
  mode = "n",
  prefix = "[",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local prev_bracket_mappings = {
  g = { "<cmd>Gitsigns prev_hunk<cr>", "Previous Hunk" },
  t = { "<cmd>tabprev<cr>", "Previous Tab" },
  n = { "<cmd>lua require('neotest').jump.prev({ status = 'failed' })", "Previous Failed" },
}

-- Next Bracket
local next_bracket_opts = {
  mode = "n",
  prefix = "]",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local next_bracket_mappings = {
  g = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
  t = { "<cmd>tabnext<cr>", "Next Tab" },
  n = { "<cmd>lua require('neotest').jump.next({ status = 'failed' })", "Next Failed" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(backslash_mappings, backslash_opts)
which_key.register(v_mappings, v_opts)
which_key.register(v_backslash_mappings, v_backslash_opts)
which_key.register(prev_bracket_mappings, prev_bracket_opts)
which_key.register(next_bracket_mappings, next_bracket_opts)
