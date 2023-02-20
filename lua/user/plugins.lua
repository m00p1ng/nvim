local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

lazy.setup({
  -- Lua Development
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "ray-x/lsp_signature.nvim",
  "RRethy/vim-illuminate",
  "b0o/SchemaStore.nvim",
  "j-hui/fidget.nvim",
  "simrat39/symbols-outline.nvim",
  "SmiteshP/nvim-navic",

  -- Completion
  {
    "hrsh7th/nvim-cmp", -- The completion plugin
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- buffer completions
      "hrsh7th/cmp-path", -- path completions
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "rcarriga/cmp-dap",
      { "tzachar/cmp-tabnine", build = "./install.sh" },
    }
  },

  -- Snippet
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
      "Wansmer/treesj",
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "ThePrimeagen/refactoring.nvim",
    },
  },

  -- Color
  "NvChad/nvim-colorizer.lua",

  -- Colorschemes
  "m00p1ng/darkplus.nvim",

  -- Utility
  "rcarriga/nvim-notify",
  "moll/vim-bbye",
  "tpope/vim-repeat",
  { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      { "mxsdev/nvim-dap-vscode-js", ft = { "javascript", "typescript" } },
      { "mfussenegger/nvim-dap-python", ft = "python" },
    }
  },

  -- StatusLine
  "nvim-lualine/lualine.nvim",

  -- StartUp
  "goolord/alpha-nvim",

  -- Indent
  "lukas-reineke/indent-blankline.nvim",

  -- File Explorer
  "nvim-tree/nvim-web-devicons",
  "nvim-tree/nvim-tree.lua",

  -- Comment
  "numToStr/Comment.nvim",
  "folke/todo-comments.nvim",

  -- Terminal
  "numToStr/Navigator.nvim",

  -- Quickfix
  "kevinhwang91/nvim-bqf",

  -- Git
  "lewis6991/gitsigns.nvim",
  "f-person/git-blame.nvim",
  "ruifm/gitlinker.nvim",
  "TimUntersberger/neogit",
  "sindrets/diffview.nvim",
  "akinsho/git-conflict.nvim",

  -- Editing Support
  "windwp/nvim-autopairs",
  "monaqa/dial.nvim",
  "andymass/vim-matchup",
  "karb94/neoscroll.nvim",
  "ntpeters/vim-better-whitespace",
  "ur4ltz/surround.nvim",
  "folke/zen-mode.nvim",
  -- use { "0x100101/lab.nvim", run = 'cd js && npm ci' }

  -- Test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
    }
  },

  -- Web development
  { "NTBBloodbath/rest.nvim", ft = "http" },

  -- Keybinding
  "folke/which-key.nvim",

  -- Spell checker
  "kamykn/spelunker.vim",

  -- Programming languages support
  { "akinsho/flutter-tools.nvim", ft = "dart" },
  { "jose-elias-alvarez/typescript.nvim" },

  'wakatime/vim-wakatime',
}, {
  root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
    version = nil,
    -- version = "*", -- enable this to try installing the latest stable versions of plugins
  },
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
  concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
  git = {
    -- defaults for the `Lazy log` command
    -- log = { "-10" }, -- show the last 10 commits
    log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 120, -- kill processes that take more than 2 minutes
    url_format = "https://github.com/%s.git",
  },
  dev = {
    -- directory where you store your local plugin projects
    path = "~/projects",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {"folke"}
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "habamax" },
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
    icons = {
      loaded = "●",
      not_loaded = "○",
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      keys = " ",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      lazy = "鈴 ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
    throttle = 20, -- how frequently should the ui process render events
    custom_keys = {
      -- you can define custom key maps here.
      -- To disable one of the defaults, set it to false

      -- open lazygit log
      ["<localleader>l"] = function(plugin)
        require("lazy.util").open_cmd({ "lazygit", "log" }, {
          cwd = plugin.dir,
          terminal = true,
          close_on_exit = true,
          enter = true,
        })
      end,

      -- open a terminal for the plugin dir
      ["<localleader>t"] = function(plugin)
        require("lazy.util").open_cmd({ vim.go.shell }, {
          cwd = plugin.dir,
          terminal = true,
          close_on_exit = true,
          enter = true,
        })
      end,
    },
  },
  diff = {
    -- diff command <d> can be one of:
    -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
    --   so you can have a different command for diff <d>
    -- * git: will run git diff and open a buffer with filetype git
    -- * terminal_git: will open a pseudo terminal with git diff
    -- * diffview.nvim: will open Diffview to show the diff
    cmd = "git",
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
      -- Once one of the following events triggers, caching will be disabled.
      -- To cache all modules, set this to `{}`, but that is not recommended.
      -- The default is to disable on:
      --  * VimEnter: not useful to cache anything else beyond startup
      --  * BufReadPre: this will be triggered early when opening a file from the command line directly
      disable_events = { "VimEnter", "BufReadPre" },
      ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to indluce in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    root = vim.fn.stdpath("state") .. "/lazy/readme",
    files = { "README.md" },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },
})
